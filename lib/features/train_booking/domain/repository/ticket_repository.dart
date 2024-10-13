import '../entities/ticket.dart';

abstract class BaseTicketRepository {
  Future<Ticket> getTicketByTrainId(String trainId);
}