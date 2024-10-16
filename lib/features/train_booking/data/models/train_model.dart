import 'package:mahattaty/features/train_booking/data/models/train_seat_model.dart';
import 'package:mahattaty/features/train_booking/domain/entities/train.dart';

class TrainModel extends Train {
  TrainModel(
    super.id, {
    required super.trainType,
    required super.trainSeats,
    required super.trainDepartureTime,
    required super.trainArrivalTime,
    required super.trainDepartureStation,
    required super.trainBookedSeats,
    required super.trainTotalSeats,
    required super.trainArrivalStation,
    required super.trainDepartureDate,
    required super.trainArrivalDate,
    required super.trainDuration,
    required super.trainStatus,
    required super.trainName,
    required super.trainNumber,
    required super.seatDiscountDate,
    required super.seatDiscount,
    required super.trainSeatsStatus,
  });

  factory TrainModel.fromFireStore(Map<String, dynamic> map, String id) {
    return TrainModel(id,
        trainName: map['trainName'],
        trainNumber: map['trainNumber'],
        trainType: TrainType.values.firstWhere(
          (element) => element.toString() == 'TrainType.${map["trainType"]}',
        ),
        trainSeats: (map['trainSeats'] as List)
            .map((e) => TrainSeatModel.fromFireStore(e))
            .toList(),
        trainDepartureTime: map['trainDepartureTime'],
        trainArrivalTime: map['trainArrivalTime'],
        trainSeatsStatus: TrainSeatsStatus.values.firstWhere(
          (element) => element.name.toString() == '${map["trainSeatsStatus"]}',
          orElse: () => TrainSeatsStatus.booked,
        ), trainDepartureStation: TrainStations.values.firstWhere(
      (element) {
        return element.name.toLowerCase() ==
            '${map["trainDepartureStation"].toLowerCase()}';
      },
    ), trainArrivalStation: TrainStations.values.firstWhere(
      (element) {
        return element.name.toLowerCase() ==
            '${map["trainArrivalStation"].toLowerCase()}';
      },
    ),
        trainBookedSeats: int.parse(map['trainBookedSeats'].toString()),
        trainTotalSeats: int.parse(map['trainTotalSeats'].toString()),
        trainDepartureDate: map['trainDepartureDate'],
        trainArrivalDate: map['trainArrivalDate'],
        trainDuration: map['trainDuration'],
        trainStatus: TrainStatus.values.firstWhere(
          (element) =>
              element.toString() == 'TrainStatus.${map["trainStatus"]}',
        ),
        seatDiscountDate: map['seatDiscountEndDate'],
        seatDiscount: double.parse(map['seatDiscount'].toString()));
  }

  Map<String, Object> toMap() {
    return {
      'trainName': trainName,
      'trainNumber': trainNumber,
      'trainType': trainType.toString().split('.').last,
      'trainSeats': trainSeats.map((e) => e.toMap()).toList(),
      'trainDepartureTime': trainDepartureTime,
      'trainArrivalTime': trainArrivalTime,
      'trainSeatsStatus': trainSeatsStatus.name,
      'trainDepartureStation': trainDepartureStation.name,
      'trainArrivalStation': trainArrivalStation.name,
      'trainBookedSeats': trainBookedSeats,
      'trainTotalSeats': trainTotalSeats,
      'trainDepartureDate': trainDepartureDate,
      'trainArrivalDate': trainArrivalDate,
      'trainDuration': trainDuration,
      'trainStatus': trainStatus.toString().split('.').last,
      'seatDiscountEndDate': seatDiscountDate,
      'seatDiscount': seatDiscount,
    };
  }

  @override
  String toString() {
    return 'TrainModel(id: $id, trainName: $trainName, trainNumber: $trainNumber, trainType: $trainType, trainSeats: $trainSeats, trainDepartureTime: $trainDepartureTime, trainArrivalTime: $trainArrivalTime, trainDepartureStation: $trainDepartureStation, trainBookedSeats: $trainBookedSeats, trainTotalSeats: $trainTotalSeats, trainArrivalStation: $trainArrivalStation, trainDepartureDate: $trainDepartureDate, trainArrivalDate: $trainArrivalDate, trainDuration: $trainDuration, trainStatus: $trainStatus)';
  }
}
