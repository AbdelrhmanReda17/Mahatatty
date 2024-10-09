enum SeatType {
  economic('Economic'),
  business('Business'),
  firstClass('First Class');

  final String name;

  const SeatType(this.name);
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
