import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      final oldTicket = await fireStore
          .collection('tickets')
          .where('userId', isEqualTo: userId)
          .get();
      if (oldTicket.docs.isNotEmpty) {
        throw ('You have already booked a ticket');
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
      await fireStore.collection('tickets').doc(ticketId).update({
        'status': status.toString().split('.').last,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> cancelTrainTicket(String ticketId) async {
    try {
      final ticket = await fireStore.collection('tickets').doc(ticketId).get();
      final ticketData = ticket.data() as Map<String, dynamic>;
      final train =
          await fireStore.collection('trains').doc(ticketData['trainId']).get();
      final trainData = train.data() as Map<String, dynamic>;
      await fireStore.collection('tickets').doc(ticketId).delete();
      await fireStore.collection('trains').doc(ticketData['trainId']).update({
        'trainBookedSeats': trainData['trainBookedSeats'] - 1,
        'TrainSeatsStatus':
            trainData['trainBookedSeats'] - 1 == trainData['trainTotalSeats']
                ? 'booked'
                : 'available',
        'trainSeats': trainData['trainSeats'].map((e) {
          if (e['seatType'] == ticketData['seatType']) {
            return {
              'seatType': e['seatType'],
              'numberOfSeats': e['numberOfSeats'],
              'bookedSeats': e['bookedSeats'] - 1,
              'seatPrice': e['seatPrice'],
            };
          }
          return e;
        }).toList(),
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TrainModel>> getAllTrains() {
    try {
      return fireStore
          .collection('trains')
          .where('trainSeatsStatus', isEqualTo: 'available')
          .get()
          .then((snapshot) {
        return snapshot.docs.map((doc) {
          return TrainModel.fromFireStore(doc.data(), doc.id);
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TrainModel>> getBestOffersTrains() async {
    try {
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
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<TrainModel>> getTrainsBySearch(
      {required TicketType ticket,
      required TrainStations from,
      required TrainStations to,
      DateTime? fromDateTime}) async {
    try {
      final trains = await fireStore
          .collection('trains')
          .where('trainDepartureStation', isEqualTo: from.name.toLowerCase())
          .where('trainArrivalStation', isEqualTo: to.name.toLowerCase())
          .get()
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
      final result = await fireStore
          .collection('tickets')
          .where('userId', isEqualTo: userId)
          .get();
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
