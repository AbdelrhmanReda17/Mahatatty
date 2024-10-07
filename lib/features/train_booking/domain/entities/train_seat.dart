enum SeatType {
  economic,
  business,
  firstClass,
}

class TrainSeats {
  final double numberOfSeats;
  final SeatType seatType;
  final double seatPrice;

  TrainSeats({
    required this.numberOfSeats,
    required this.seatType,
    required this.seatPrice,
  });
}
