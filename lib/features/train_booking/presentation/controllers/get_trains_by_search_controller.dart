import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/presentation/controllers/search_train_controller.dart';
import 'package:mahattaty/features/train_booking/presentation/providers/get_trains_by_search_provider.dart';

import '../../domain/entities/train.dart';

final trainsBySearchController =
    FutureProvider.family<List<Train>, TrainSearchState>((ref, query) {
  ref.state = const AsyncValue.loading();
  try {
    final trains = ref.read(getTrainsBySearchUseCaseProvider).call(
          ticket: query.ticketType,
          from: query.fromStation!,
          to: query.toStation!,
          fromDateTime: query.departureDate.toDate(),
          toDateTime: query.arrivalDate.toDate(),
        );
    return trains;
  } catch (e) {
    ref.state = AsyncValue.error(e, e as StackTrace);
    rethrow;
  }
});
