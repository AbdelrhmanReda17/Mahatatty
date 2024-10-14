import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/presentation/providers/train_provider.dart';

import '../../domain/usecases/book_train_ticket.dart';

final bookTrainTicketProvider = Provider<BookTrainTicketUseCase>((ref) {
  return BookTrainTicketUseCase(ref.read(trainRepositoryProvider));
});
