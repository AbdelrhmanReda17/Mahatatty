import 'package:mahattaty/features/train_booking/data/datasource/tickets_remote_data_source.dart';
import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';
import 'package:mahattaty/features/train_booking/domain/repository/ticket_repository.dart';
import 'package:mahattaty/features/train_booking/domain/repository/train_repository.dart';

class TicketRepository implements BaseTicketRepository {
  final BaseTicketRemoteDataSource remoteDataSource;

  TicketRepository(this.remoteDataSource);

  @override
  Future<Ticket> getTicketByTrainId(String trainId) {
    return remoteDataSource.getTicketByTrainId(trainId);
  }

}