import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/train.dart';
import '../providers/get_best_offers_trains_provider.dart';

final bestOffersTrainsController = FutureProvider<List<Train>>((ref) async {
  ref.state = const AsyncValue.loading();
  try {
    final trains = await ref.read(getBestOffersTrainsProvider).call();
    return trains;
  } catch (e, stackTrace) {
    ref.state = AsyncValue.error(e, e as StackTrace);
    rethrow;
  }
});
