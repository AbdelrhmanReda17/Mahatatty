import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/train.dart';

class TrainSearchState {
  TicketType ticketType = TicketType.oneWay;
  TrainStations fromStation;
  TrainStations toStation;
  Timestamp arrivalDate;
  Timestamp departureDate;

  TrainSearchState({
    this.ticketType = TicketType.oneWay,
    this.fromStation = TrainStations.alexandria,
    this.toStation = TrainStations.cairo,
    Timestamp? arrivalDate,
    Timestamp? departureDate,
  })  : arrivalDate = arrivalDate ?? Timestamp.now(),
        departureDate = departureDate ?? Timestamp.now();

  TrainSearchState copyWith({
    TicketType? ticketType,
    TrainStations? fromStation,
    TrainStations? toStation,
    Timestamp? arrivalDate,
    Timestamp? departureDate,
  }) {
    return TrainSearchState(
      ticketType: ticketType ?? this.ticketType,
      fromStation: fromStation ?? this.fromStation,
      toStation: toStation ?? this.toStation,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      departureDate: departureDate ?? this.departureDate,
    );
  }

  @override
  String toString() {
    return 'SearchState(ticketType: $ticketType, fromStation: $fromStation, toStation: $toStation, arrivalDate: $arrivalDate, departureDate: $departureDate)';
  }
}

final trainSearchProvider = StateProvider<TrainSearchState>((ref) {
  return TrainSearchState();
});
