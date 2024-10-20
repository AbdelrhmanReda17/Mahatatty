import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mahattaty/features/train_booking/data/models/train_seat_model.dart';

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
  cairo('CAI'),
  alexandria('ALX'),
  aswan('ASW'),
  luxor('LXR'),
  asyut('ATZ'),
  beni_suef('BFS'),
  damietta('DTT'),
  faiyum('FYM'),
  gharbia('GBY'),
  giza('GIZ'),
  ismailia('ISM'),
  kafr_el_sheikh('KFS'),
  matruh('MTW'),
  minya('MYN'),
  monufia('MNF'),
  new_valley('WAD'),
  north_sinai('SIN'),
  port_said('PSD'),
  qalyubia('QAL'),
  qena('QNA'),
  red_sea('BAV'),
  sharqia('SHR'),
  sohag('SWJ'),
  south_sinai('SSH'),
  suez('SUZ'),
  dakahlia('DKA'),
  el_bahariya('BAH'),
  el_wadi_el_gedid('WAD'),
  el_fayoum('FYM'),
  el_menoufia('MNF'),
  el_monufia('MNF');

  final String code;

  const TrainStations(this.code);

  @override
  String toString() {
    return 'TrainStations(code: $code)';
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
  express('Express'),
  ordinary('Ordinary'),
  touristic('Touristic');

  final String name;

  const TrainType(this.name);
}

class Train {
  final String id;
  final String trainName;
  final String trainNumber;
  final TrainType trainType;
  final String trainDepartureTime;
  final List<TrainSeatModel> trainSeats;
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
