import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/train.dart';

class SearchState {
  TicketType ticketType;
  TrainStations? fromStation;
  TrainStations? toStation;
  Timestamp arrivalDate;
  Timestamp departureDate;

  SearchState({
    this.ticketType = TicketType.oneWay,
    this.fromStation,
    this.toStation,
    Timestamp? arrivalDate,
    Timestamp? departureDate,
  })  : arrivalDate = arrivalDate ?? Timestamp.now(),
        departureDate = departureDate ?? Timestamp.now();

  SearchState copyWith({
    TicketType? ticketType,
    TrainStations? fromStation,
    TrainStations? toStation,
    Timestamp? arrivalDate,
    Timestamp? departureDate,
  }) {
    return SearchState(
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

final searchProvider = StateProvider<SearchState>((ref) {
  return SearchState();
});
