import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/domain/usecases/cancel_train_ticket.dart';
import 'package:mahattaty/features/train_booking/presentation/providers/train_provider.dart';

final cancelTrainTicketProvider = Provider<CancelTrainTicketUseCase>((ref) {
  return CancelTrainTicketUseCase(ref.read(trainRepositoryProvider));
});
