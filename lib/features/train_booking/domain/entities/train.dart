import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mahattaty/features/train_booking/domain/entities/train_seat.dart';

enum TrainStatus {
  onTime,
  delayed,
  canceled,
}

enum TrainSeatsStatus {
  available,
  booked,
}

enum TrainStations {
  cairo('Cairo', 'CAI'),
  alexandria('Alexandria', 'ALX'),
  aswan('Aswan', 'ASW'),
  luxor('Luxor', 'LXR'),
  asyut('Asyut', 'ATZ'),
  beni_suef('Beni Suef', 'BFS'),
  damietta('Damietta', 'DTT'),
  faiyum('Faiyum', 'FYM'),
  gharbia('Gharbia', 'GBY'),
  giza('Giza', 'GIZ'),
  ismailia('Ismailia', 'ISM'),
  kafr_el_sheikh('Kafr El Sheikh', 'KFS'),
  matruh('Matruh', 'MTW'),
  minya('Minya', 'MYN'),
  monufia('Monufia', 'MNF'),
  new_valley('New Valley', 'WAD'),
  north_sinai('North Sinai', 'SIN'),
  port_said('Port Said', 'PSD'),
  qalyubia('Qalyubia', 'QAL'),
  qena('Qena', 'QNA'),
  red_sea('Red Sea', 'BAV'),
  sharqia('Sharqia', 'SHR'),
  sohag('Sohag', 'SWJ'),
  south_sinai('South Sinai', 'SSH'),
  suez('Suez', 'SUZ'),
  dakahlia('Dakahlia', 'DKA'),
  el_bahariya('El Bahariya', 'BAH'),
  el_wadi_el_gedid('El Wadi El Gedid', 'WAD'),
  el_fayoum('El Fayoum', 'FYM'),
  el_menoufia('El Menoufia', 'MNF'),
  el_monufia('El Monufia', 'MNF'),
  ;

  final String name;
  final String code;

  const TrainStations(this.name, this.code);

  @override
  String toString() {
    return 'TrainStations(name: $name, code: $code)';
  }

  // get all stations
  static List<TrainStations> get allStations => [
        TrainStations.cairo,
        TrainStations.alexandria,
        TrainStations.aswan,
        TrainStations.luxor,
        TrainStations.asyut,
        TrainStations.beni_suef,
        TrainStations.damietta,
        TrainStations.faiyum,
        TrainStations.gharbia,
        TrainStations.giza,
        TrainStations.ismailia,
        TrainStations.kafr_el_sheikh,
        TrainStations.matruh,
        TrainStations.minya,
        TrainStations.monufia,
        TrainStations.new_valley,
        TrainStations.north_sinai,
        TrainStations.port_said,
        TrainStations.qalyubia,
        TrainStations.qena,
        TrainStations.red_sea,
        TrainStations.sharqia,
        TrainStations.sohag,
        TrainStations.south_sinai,
        TrainStations.suez,
        TrainStations.dakahlia,
        TrainStations.el_bahariya,
        TrainStations.el_wadi_el_gedid,
        TrainStations.el_fayoum,
        TrainStations.el_menoufia,
        TrainStations.el_monufia,
      ];
}

enum TrainType {
  express,
  ordinary,
}

class Train {
  final String id;
  final String trainName;
  final String trainNumber;
  final TrainType trainType;
  final String trainDepartureTime;
  final List<TrainSeats> trainSeats;
  final int trainBookedSeats;
  final TrainSeatsStatus trainSeatsStatus;
  final int trainTotalSeats;
  final String trainArrivalTime;
  final Timestamp seatDiscountDate;
  double seatDiscount;
  final TrainStations trainDepartureStation;
  final TrainStations trainArrivalStation;
  final Timestamp trainDepartureDate;
  final Timestamp trainArrivalDate;
  final String trainDuration;
  final TrainStatus trainStatus;

  Train(
    this.id, {
    required this.trainName,
    required this.trainNumber,
    required this.trainType,
    required this.trainDepartureTime,
    required this.trainSeats,
    required this.trainArrivalTime,
    required this.trainBookedSeats,
    this.trainSeatsStatus = TrainSeatsStatus.available,
    required this.trainTotalSeats,
    required this.trainDepartureStation,
    required this.seatDiscountDate,
    this.seatDiscount = 0.0,
    required this.trainArrivalStation,
    required this.trainDepartureDate,
    required this.trainArrivalDate,
    required this.trainDuration,
    required this.trainStatus,
  });

  @override
  String toString() {
    return 'Train(id: $id, trainName: $trainName, trainNumber: $trainNumber, trainType: $trainType, trainDepartureTime: $trainDepartureTime, trainSeats: $trainSeats, trainArrivalTime: $trainArrivalTime, trainBookedSeats: $trainBookedSeats, trainSeatsStatus: $trainSeatsStatus, trainTotalSeats: $trainTotalSeats, trainDepartureStation: $trainDepartureStation, seatDiscountDate: $seatDiscountDate, seatDiscount: $seatDiscount, trainArrivalStation: $trainArrivalStation, trainDepartureDate: $trainDepartureDate, trainArrivalDate: $trainArrivalDate, trainDuration: $trainDuration, trainStatus: $trainStatus)';
  }
}
