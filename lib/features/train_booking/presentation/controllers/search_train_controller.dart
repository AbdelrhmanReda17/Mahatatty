import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/train.dart';

class TrainSearchState {
  TicketType ticketType;
  TrainStations fromStation;
  TrainStations toStation;
  Timestamp departureDate;

  TrainSearchState({
    this.ticketType = TicketType.oneWay,
    this.fromStation = TrainStations.cairo,
    this.toStation = TrainStations.alexandria,
    Timestamp? departureDate,
  }) : departureDate = departureDate ?? Timestamp.now();

  TrainSearchState copyWith({
    TicketType? ticketType,
    TrainStations? fromStation,
    TrainStations? toStation,
    Timestamp? departureDate,
  }) {
    return TrainSearchState(
      ticketType: ticketType ?? this.ticketType,
      fromStation: fromStation ?? this.fromStation,
      toStation: toStation ?? this.toStation,
      departureDate: departureDate ?? this.departureDate,
    );
  }

  @override
  String toString() {
    return 'SearchState(ticketType: $ticketType, fromStation: $fromStation, toStation: $toStation, departureDate: $departureDate)';
  }
}

final trainSearchProvider = StateProvider.autoDispose<TrainSearchState>((ref) {
  return TrainSearchState();
});
