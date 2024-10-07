import 'package:mahattaty/features/train_booking/domain/repository/train_repository.dart';

class CancelTrainTicketUseCase {
  final BaseTrainRepository repository;

  CancelTrainTicketUseCase(this.repository);

  Future<void> call(String ticketId) async {
    return repository.cancelTrainTicket(ticketId);
  }
}
