// TrainModel train = TrainModel(
//   id: firestore.databaseId,
//   trainName: 'Express Train',
//   trainNumber: '12345',
//   trainType: TrainType.express,
//   trainDepartureTime: '10:00 AM',
//   trainArrivalTime: '02:00 PM',
//   trainDepartureStation: 'Central Station',
//   trainArrivalStation: 'North Station',
//   trainDepartureDate: DateTime.now(),
//   trainArrivalDate: DateTime.now().add(const Duration(hours: 4)),
//   trainDuration: '4h',
//   trainStatus: TrainStatus.onTime,
//   trainBookedSeats: 0,
//   trainTotalSeats: 35,
//   trainSeats: [
//     TrainSeatModel(
//       seatType: SeatType.firstClass,
//       numberOfSeats: 10,
//       seatPrice: 100.0,
//     ),
//     TrainSeatModel(
//       seatType: SeatType.economic,
//       numberOfSeats: 20,
//       seatPrice: 50.0,
//     ),
//     TrainSeatModel(
//       seatType: SeatType.business,
//       numberOfSeats: 5,
//       seatPrice: 200.0,
//     ),
//   ],
// );
//
// firestore.collection('trains').add(
//   {
//     'trainName': train.trainName,
//     'trainNumber': train.trainNumber,
//     'trainType': train.trainType.toString().split('.').last,
//     'trainDepartureTime': train.trainDepartureTime,
//     'trainArrivalTime': train.trainArrivalTime,
//     'trainDepartureStation': train.trainDepartureStation,
//     'trainArrivalStation': train.trainArrivalStation,
//     'trainBookedSeats': train.trainBookedSeats,
//     'trainTotalSeats': train.trainTotalSeats,
//     'trainDepartureDate': train.trainDepartureDate,
//     'trainArrivalDate': train.trainArrivalDate,
//     'trainDuration': train.trainDuration,
//     'trainStatus': train.trainStatus.toString().split('.').last,
//     'trainSeats': train.trainSeats.map((seat) {
//       return {
//         'seatType': seat.seatType.toString().split('.').last,
//         'numberOfSeats': seat.numberOfSeats,
//         'seatPrice': seat.seatPrice,
//       };
//     }).toList(),
//   },
// );

// QuerySnapshot snapshot2 = await firestore.collection('trains').get();
// List<TrainModel> trainList = snapshot2.docs.map((doc) {
//   return TrainModel.fromFireStore(
//       doc.data() as Map<String, dynamic>, doc.id);
// }).toList();
//
// for (var element in trainList) {
//   log('Train: ${element.toString()}');
// }

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  Future<void> bookTrainTicket(Ticket ticket);

  Future<void> cancelTrainTicket(String ticketId);

  Future<List<TrainModel>> getBestOffersTrains();

  Future<Map<TicketModel, TrainModel>> getUserBookedTrains(String userId);

  Future<Train> getTrainById(String trainId);

  // Future<List<Train>> getFilteredTickets({
  //   required List<String> trainTypes,
  //   required double minPrice,
  //   required double maxPrice,
  // });
}

class TrainsRemoteDataSource implements BaseTrainsRemoteDataSource {
  final FirebaseFirestore fireStore;

  TrainsRemoteDataSource(this.fireStore);

  @override
  Future<void> bookTrainTicket(Ticket ticket) {
    try {
      fireStore.collection('trains').doc(ticket.trainId).get().then((doc) {
        final train = TrainModel.fromFireStore(
            doc.data() as Map<String, dynamic>, doc.id);
        final bookedSeats = train.trainBookedSeats + 1;
        fireStore.collection('trains').doc(ticket.trainId).update({
          'trainBookedSeats': bookedSeats,
          'TrainSeatsStatus':
              bookedSeats == train.trainTotalSeats ? 'booked' : 'available',
        });
      });
      return fireStore.collection('tickets').add({
        'trainId': ticket.trainId,
        'userId': ticket.userId,
        'seatType': ticket.seatType.toString().split('.').last,
        'status': ticket.status.toString().split('.').last,
        'type': ticket.type.toString().split('.').last,
        'price': ticket.price,
        'bookingDate': ticket.bookingDate,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> cancelTrainTicket(String ticketId) {
    try {
      return fireStore.collection('tickets').doc(ticketId).get().then((doc) {
        final ticket = TicketModel.fromFireStore(
            doc.data() as Map<String, dynamic>, doc.id);
        fireStore.collection('trains').doc(ticket.trainId).get().then((doc) {
          final train = TrainModel.fromFireStore(
              doc.data() as Map<String, dynamic>, doc.id);
          final bookedSeats = train.trainBookedSeats - 1;
          fireStore.collection('trains').doc(ticket.trainId).update({
            'trainBookedSeats': bookedSeats,
            'TrainSeatsStatus': 'available',
          });
        });
        // Update ticket status after cancellation
        fireStore.collection('tickets').doc(ticketId).update({
          'status' : 'canceled'
        });
      });
    } catch (e) {
      throw Exception(e);
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
      throw Exception(e);
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
      log('getBestOffersTrains: $trains');
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
          return train.trainDepartureDate.toDate().isAfter(fromDateTime);
        }
        return false;
      }).toList();
    } catch (e) {
      throw Exception(e);
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
      throw Exception(e);
    }
  }

  @override
  Future<TrainModel> getTrainById(String trainId) async{
    try{
      final train = await fireStore.collection('trains').doc(trainId).get();
      if (train.exists){
        return TrainModel.fromFireStore(train.data()!, trainId);
      }
      throw Exception('Train was Not Found');
    }
    catch(e){
      throw Exception('Error Fetching Train Data: $e');
    }

  }

  // @override
  // Future<List<Ticket>> getFilteredTickets({
  //   required List<String> trainTypes,
  //   required double minPrice,
  //   required double maxPrice
  // }) async {
  //   try {
  //
  //     final tickets = await fireStore
  //         .collection('tickets')
  //         .where('price', isGreaterThanOrEqualTo: minPrice)
  //         .where('price', isLessThanOrEqualTo: maxPrice)
  //         .get()
  //         .then((snapshot) {
  //           return snapshot.docs.map((doc) {
  //             return TicketModel.fromFireStore(doc.data(), doc.id);
  //           }).toList();
  //         });
  //
  //     final trains = <TrainModel>[];
  //     for (var ticket in tickets){
  //       final train = await fireStore
  //           .collection('tickets').doc(ticket.trainId)
  //           .where('price', isGreaterThanOrEqualTo: minPrice)
  //           .where('price', isLessThanOrEqualTo: maxPrice)
  //           .get();
  //       tickets.add(
  //         TicketModel.fromFireStore(
  //             ticket.data() as Map<String, dynamic>, ticket.id),
  //       );
  //     }
  // }
}
