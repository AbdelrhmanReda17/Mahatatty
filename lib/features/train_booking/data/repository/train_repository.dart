import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/ticket.dart';
import '../../domain/entities/train.dart';
import '../../domain/entities/train_seat.dart';
import '../../domain/repository/train_repository.dart';
import '../datasource/trains_remote_data_source.dart';

class TrainRepository implements BaseTrainRepository {
  final BaseTrainsRemoteDataSource remoteDataSource;

  TrainRepository(this.remoteDataSource);

  @override
  Future<String> bookTrainTicket({
    required TicketType ticketType,
    required String trainId,
    required Timestamp bookingDate,
    required SeatType seat,
    required String userId,
  }) {
    return remoteDataSource.bookTrainTicket(
      ticketType: ticketType,
      trainId: trainId,
      bookingDate: bookingDate,
      seat: seat,
      userId: userId,
    );
  }

  @override
  Future<void> changeTrainTicketStatus(String ticketId, TicketStatus status) {
    return remoteDataSource.changeTrainTicketStatus(ticketId, status);
  }

  @override
  Future<void> cancelTrainTicket(String ticketId) {
    return remoteDataSource.cancelTrainTicket(ticketId);
  }

  @override
  Future<List<Train>> getAllTrains() {
    return remoteDataSource.getAllTrains();
  }

  @override
  Future<List<Train>> getBestOffersTrains() {
    return remoteDataSource.getBestOffersTrains();
  }

  @override
  Future<List<Train>> getTrainsBySearch(
      {required TicketType ticket,
      required TrainStations from,
      required TrainStations to,
      DateTime? fromDateTime}) {
    return remoteDataSource.getTrainsBySearch(
      ticket: ticket,
      from: from,
      to: to,
      fromDateTime: fromDateTime,
    );
  }

  @override
  Future<Map<Ticket, Train>> getUserBookedTrains(String userId) {
    return remoteDataSource.getUserBookedTrains(userId);
  }

  @override
  Future<Train> getTrainById(String trainId) {
    return remoteDataSource.getTrainById(trainId);
  }
}
