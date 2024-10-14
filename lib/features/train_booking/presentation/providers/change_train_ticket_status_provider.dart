import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/presentation/providers/train_provider.dart';

import '../../domain/usecases/change_train_ticket_status.dart';

final changeTrainTicketStatusProvider =
    Provider<ChangeTrainTicketStatusUseCase>((ref) {
  return ChangeTrainTicketStatusUseCase(ref.read(trainRepositoryProvider));
});
