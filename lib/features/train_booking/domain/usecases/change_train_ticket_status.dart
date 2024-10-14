import '../entities/ticket.dart';
import '../repository/train_repository.dart';

class ChangeTrainTicketStatusUseCase {
  final BaseTrainRepository repository;

  ChangeTrainTicketStatusUseCase(this.repository);

  Future<void> call({
    required String ticketId,
    required TicketStatus status,
  }) async {
    return await repository.changeTrainTicketStatus(
      ticketId,
      status,
    );
  }
}
