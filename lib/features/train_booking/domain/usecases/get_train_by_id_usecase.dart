import 'package:mahattaty/features/train_booking/domain/repository/train_repository.dart';

import '../entities/ticket.dart';
import '../entities/train.dart';

class GetTrainsBySearch {
  final BaseTrainRepository repository;

  GetTrainsBySearch(this.repository);

  Future<Train> call({
    required TicketType ticket,
    required TrainStations from,
    required TrainStations to,
    DateTime? fromDateTime,
    DateTime? toDateTime,
  }) async {
    return await repository.getTrainsBySearch(
      ticket: ticket,
      from: from,
      to: to,
      fromDateTime: fromDateTime,
      toDateTime: toDateTime,
    );
  }
}
