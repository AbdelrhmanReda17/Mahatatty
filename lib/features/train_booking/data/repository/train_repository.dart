import '../../domain/entities/ticket.dart';
import '../../domain/entities/train.dart';
import '../../domain/repository/train_repository.dart';
import '../datasource/trains_remote_data_source.dart';
import '../models/train_model.dart';

class TrainRepository implements BaseTrainRepository {
  final BaseTrainsRemoteDataSource remoteDataSource;

  TrainRepository(this.remoteDataSource);

  @override
  Future<void> bookTrainTicket(Ticket ticket) {
    return remoteDataSource.bookTrainTicket(ticket);
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
      DateTime? fromDateTime,
      DateTime? toDateTime}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Ticket>> getUserBookedTrains(String userId) {
    // TODO: implement getUserBookedTrains
    throw UnimplementedError();
  }
}
