import 'dart:developer';

import 'package:mahattaty/features/train_booking/domain/entities/train_seat.dart';

class TrainSeatModel extends TrainSeats {
  TrainSeatModel({
    required super.seatType,
    required super.numberOfSeats,
    required super.seatPrice,
  });

  factory TrainSeatModel.fromFireStore(Map<String, dynamic> data) {
    log(SeatType.values
        .firstWhere(
          (element) => element.toString() == 'SeatType.${data["seatType"]}',
        )
        .toString());
    log(data["numberOfSeats"].toString());
    log(data["seatPrice"].toString());

    return TrainSeatModel(
      seatType: SeatType.values.firstWhere(
        (element) => element.toString() == 'SeatType.${data["seatType"]}',
      ),
      numberOfSeats: data['numberOfSeats'],
      seatPrice: data['seatPrice'],
    );
  }
//
// Map<String, dynamic> toMap() {
//   return {
//     'seatType': seatType.toString().split('.').last,
//     'numberOfSeats': numberOfSeats,
//     'seatPrice': seatPrice,
//   };
// }
}
