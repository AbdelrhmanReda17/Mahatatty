import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';
import '../repository/ticket_repository.dart';

class GetTicketByTrainId {
  final BaseTicketRepository repository;

  GetTicketByTrainId(this.repository);

  Future<Ticket> call({required String trainId}) async{
    return await repository.getTicketByTrainId(trainId);
  }
}