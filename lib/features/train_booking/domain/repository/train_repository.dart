import '../entities/ticket.dart';
import '../entities/train.dart';

abstract class BaseTrainRepository {
  Future<List<Train>> getAllTrains();

  Future<List<Train>> getTrainsBySearch({
    required TicketType ticket,
    required TrainStations from,
    required TrainStations to,
    DateTime? fromDateTime,
    DateTime? toDateTime,
  });

  Future<List<Train>> getBestOffersTrains();

  Future<List<Ticket>> getUserBookedTrains(String userId);

  Future<void> bookTrainTicket(Ticket ticket);

  Future<void> cancelTrainTicket(String ticketId);
}
