import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mahattaty/core/utils/check_connection.dart';
import 'package:mahattaty/features/train_booking/data/models/train_seat_model.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/train.dart';
import '../../domain/entities/train_seat.dart';
import '../models/ticket_model.dart';
import '../models/train_model.dart';

abstract class BaseTrainsRemoteDataSource {
  Future<List<TrainModel>> getAllTrains();

  Future<List<TrainModel>> getTrainsBySearch(
      {required TicketType ticket,
      required TrainStations from,
      required TrainStations to,
      DateTime? fromDateTime});

  Future<String> bookTrainTicket({
    required TicketType ticketType,
    required String trainId,
    required Timestamp bookingDate,
    required SeatType seat,
    required String userId,
  });

  Future<void> cancelTrainTicket(String ticketId);

  Future<List<TrainModel>> getBestOffersTrains();

  Future<Map<TicketModel, TrainModel>> getUserBookedTrains(String userId);

  Future<Train> getTrainById(String trainId);

  Future<void> changeTrainTicketStatus(String ticketId, TicketStatus status);
}

class TrainsRemoteDataSource implements BaseTrainsRemoteDataSource {
  final FirebaseFirestore fireStore;

  TrainsRemoteDataSource(this.fireStore);


  @override
  Future<String> bookTrainTicket({
    required TicketType ticketType,
    required String trainId,
    required Timestamp bookingDate,
    required SeatType seat,
    required String userId,
  }) async {
    try {
      await  CheckConnection.checkInternetConnection();

      var oldTicket = await fireStore
          .collection('tickets')
          .where('userId', isEqualTo: userId)
          .get().timeout(const Duration(seconds: 5));
     if (oldTicket.docs.isNotEmpty)  {
        for(var ticket in oldTicket.docs) {
          final ticketModel = TicketModel.fromFireStore(
              ticket.data(),
              ticket.id
          );
          if (ticketModel.status == TicketStatus.booked &&
              ticketModel.trainId == trainId ) {
            throw ('You have already booked a ticket for this train');
          } else {
            if(ticketModel.status == TicketStatus.onHold || ticketModel.status == TicketStatus.canceled) {
              await fireStore.collection('tickets')
                  .doc(ticketModel.id)
                  .delete();
            }
          }
        }
      }
      final train =
      await fireStore.collection('trains').doc(trainId).get().then((doc) {
        return TrainModel.fromFireStore(
            doc.data() as Map<String, dynamic>, doc.id);
      });
      train.trainSeats
          .firstWhere((element) => element.seatType == seat)
          .bookedSeats++;
      await fireStore.collection('trains').doc(trainId).update(
        {
          'trainBookedSeats': train.trainBookedSeats + 1,
          'TrainSeatsStatus':
          train.trainBookedSeats + 1 == train.trainTotalSeats
              ? 'booked'
              : 'available',
          'trainSeats': train.trainSeats
              .map((e) => TrainSeatModel(
            seatType: e.seatType,
            numberOfSeats: e.numberOfSeats,
            bookedSeats: e.bookedSeats,
            seatPrice: e.seatPrice,
          ))
              .map((e) => e.toMap())
              .toList(),
        },
      );

      var ticketPrice = train.trainSeats
          .firstWhere((element) => element.seatType == seat)
          .seatPrice;

      final ticket = await fireStore.collection('tickets').add({
        'trainId': trainId,
        'userId': userId,
        'seatType': seat.toString().split('.').last,
        'status': 'onHold',
        'type': ticketType.toString().split('.').last,
        'price': ticketPrice,
        'bookingDate': bookingDate,
      });

      return ticket.id;
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<void> changeTrainTicketStatus(
      String ticketId, TicketStatus status) async {
    try {
      await  CheckConnection.checkInternetConnection();

      await fireStore.collection('tickets').doc(ticketId).update({
        'status': status.toString().split('.').last,
      }).timeout(const Duration(seconds: 5));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> cancelTrainTicket(String ticketId) async {
    try {
      await  CheckConnection.checkInternetConnection();
      final ticket = await fireStore.collection('tickets').doc(ticketId).get();
      final TicketModel ticketData = TicketModel.fromFireStore(ticket.data()!, ticket.id);
      await fireStore.collection('tickets').doc(ticketId).delete();
      final train = await fireStore.collection('trains').doc(ticketData.trainId).get();
      final TrainModel trainData = TrainModel.fromFireStore(train.data()!, train.id);

      await fireStore.collection('trains').doc(ticketData.trainId).update({
        'trainBookedSeats': FieldValue.increment(-1),
        'trainSeatsStatus': 'available',
        'trainSeats': trainData.trainSeats.map((e) {
          if (e.seatType == ticketData.seatType) e.bookedSeats--;
          return e.toMap();
        }).toList(),

      }).then((value) {
        log('Ticket Canceled Successfully');
      }).onError((error, stackTrace) {
        log('Error Canceling Ticket: $error');
      }).catchError(
        (error) {
          log('Error Canceling Ticket: $error');
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TrainModel>> getAllTrains() async{
    try  {
      await  CheckConnection.checkInternetConnection();
      return fireStore
          .collection('trains')
          .where('trainSeatsStatus', isEqualTo: 'available')
          .get()
          .then((snapshot) {
        return snapshot.docs.map((doc) {
          return TrainModel.fromFireStore(doc.data(), doc.id);
        }).toList();
      }).timeout(const Duration(seconds: 5));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TrainModel>> getBestOffersTrains() async {
    try {
      await  CheckConnection.checkInternetConnection();

      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        throw const SocketException('No Internet Connection');
      }
      final result = await FirebaseFirestore.instance
          .collection('trains')
          .where('trainSeatsStatus', isEqualTo: 'available')
          .where('seatDiscount', isGreaterThan: 0)
          .where('seatDiscountEndDate', isGreaterThan: Timestamp.now())
          .get();
      final trains = result.docs
          .map((doc) => TrainModel.fromFireStore(doc.data(), doc.id))
          .toList();
      return trains;
    } on SocketException catch (e) {
      log('Network Error: $e');
      rethrow;
    } catch (e) {
      log('Error Fetching Best Offers Trains: $e');
      rethrow;
    }
  }

  @override
  Future<List<TrainModel>> getTrainsBySearch(
      {required TicketType ticket,
      required TrainStations from,
      required TrainStations to,
      DateTime? fromDateTime}) async {
    try {
      await  CheckConnection.checkInternetConnection();

      final trains = await fireStore
          .collection('trains')
          .where('trainDepartureStation', isEqualTo: from.name.toLowerCase())
          .where('trainArrivalStation', isEqualTo: to.name.toLowerCase())
          .get().timeout(const Duration(seconds: 5))
          .then((snapshot) {
        return snapshot.docs.map((doc) {
          return TrainModel.fromFireStore(doc.data(), doc.id);
        }).toList();
      });

      return trains.where((train) {
        if (fromDateTime != null) {
          return train.trainDepartureDate.toDate().day == fromDateTime.day &&
              train.trainDepartureDate.toDate().month == fromDateTime.month &&
              train.trainDepartureDate.toDate().year == fromDateTime.year &&
              train.trainDepartureDate.toDate().hour >= fromDateTime.hour;
        }
        return false;
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<TicketModel, TrainModel>> getUserBookedTrains(
      String userId) async {
    try {
      await  CheckConnection.checkInternetConnection();

      final result = await fireStore
          .collection('tickets')
          .where('userId', isEqualTo: userId)
          .get().timeout(const Duration(seconds: 5));
      final tickets = result.docs
          .map((doc) => TicketModel.fromFireStore(doc.data(), doc.id))
          .toList();
      final trains = <TrainModel>[];
      for (var ticket in tickets) {
        final train =
            await fireStore.collection('trains').doc(ticket.trainId).get();
        trains.add(
          TrainModel.fromFireStore(
              train.data() as Map<String, dynamic>, train.id),
        );
      }
      return Map.fromIterables(tickets, trains);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TrainModel> getTrainById(String trainId) async {
    try {
      await CheckConnection.checkInternetConnection();
      final train = await fireStore.collection('trains').doc(trainId).get();
      if (train.exists) {
        return TrainModel.fromFireStore(train.data()!, trainId);
      }
      throw Exception('Train was Not Found');
    } catch (e) {
      throw Exception('Error Fetching Train Data: $e');
    }
  }
}
