import 'package:mahattaty/features/train_booking/domain/entities/train.dart';
import 'package:mahattaty/features/train_booking/domain/repository/train_repository.dart';

import '../entities/ticket.dart';

class GetUserBookedTrainsUseCase {
  final BaseTrainRepository repository;

  GetUserBookedTrainsUseCase(this.repository);

  Future<Map<Ticket, Train>> call(String userId) async {
    return repository.getUserBookedTrains(userId);
  }
}
