import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';
import 'package:mahattaty/features/train_booking/domain/repository/train_repository.dart';

class BookTrainTicket {
  final BaseTrainRepository repository;

  BookTrainTicket(this.repository);

  Future<void> call(Ticket ticket) async {
    return await repository.bookTrainTicket(ticket);
  }
}
