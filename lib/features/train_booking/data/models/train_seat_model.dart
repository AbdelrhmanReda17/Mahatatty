import 'package:mahattaty/features/train_booking/domain/entities/train_seat.dart';

class TrainSeatModel extends TrainSeats {
  TrainSeatModel({
    required super.seatType,
    required super.numberOfSeats,
    required super.bookedSeats,
    required super.seatPrice,
  });

  factory TrainSeatModel.fromFireStore(Map<String, dynamic> data) {
    return TrainSeatModel(
      seatType: SeatType.values.firstWhere(
        (element) => element.toString() == 'SeatType.${data["seatType"]}',
      ),
      numberOfSeats: double.parse(data['numberOfSeats'].toString()),
      bookedSeats: double.parse(data['bookedSeats'].toString()),
      seatPrice: double.parse(data['seatPrice'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'seatType': seatType.toString().split('.').last,
      'numberOfSeats': numberOfSeats,
      'bookedSeats': bookedSeats,
      'seatPrice': seatPrice,
    };
  }

  TrainSeatModel copyWith({
    SeatType? seatType,
    double? numberOfSeats,
    double? bookedSeats,
    double? seatPrice,
  }) {
    return TrainSeatModel(
      seatType: seatType ?? this.seatType,
      numberOfSeats: numberOfSeats ?? this.numberOfSeats,
      bookedSeats: bookedSeats ?? this.bookedSeats,
      seatPrice: seatPrice ?? this.seatPrice,
    );
  }

  @override
  String toString() {
    return 'TrainSeatModel(seatType: $seatType, numberOfSeats: $numberOfSeats, bookedSeats: $bookedSeats, seatPrice: $seatPrice)';
  }
}
