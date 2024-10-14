enum SeatType {
  economic('Economic'),
  business('Business'),
  firstClass('First Class');

  final String name;

  const SeatType(this.name);
}

class TrainSeats {
  double numberOfSeats;
  double bookedSeats;
  SeatType seatType;
  double seatPrice;

  TrainSeats({
    required this.numberOfSeats,
    required this.bookedSeats,
    required this.seatType,
    required this.seatPrice,
  });
}
