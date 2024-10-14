import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/ticket.dart';
import '../entities/train.dart';
import '../entities/train_seat.dart';

abstract class BaseTrainRepository {
  Future<List<Train>> getAllTrains();

  Future<List<Train>> getTrainsBySearch({
    required TicketType ticket,
    required TrainStations from,
    required TrainStations to,
    DateTime? fromDateTime,
  });

  Future<List<Train>> getBestOffersTrains();

  Future<Map<Ticket, Train>> getUserBookedTrains(String userId);

  Future<String> bookTrainTicket({
    required TicketType ticketType,
    required String trainId,
    required Timestamp bookingDate,
    required SeatType seat,
    required String userId,
  });

  Future<void> changeTrainTicketStatus(String ticketId, TicketStatus status);

  Future<void> cancelTrainTicket(String ticketId);

  Future<Train> getTrainById(String trainId);
}
