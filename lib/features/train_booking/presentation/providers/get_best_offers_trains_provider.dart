import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/presentation/providers/train_provider.dart';

import '../../domain/usecases/get_best_offers_trains.dart';

final getBestOffersTrainsProvider = Provider<GetBestOffersTrainsUseCase>((ref) {
  return GetBestOffersTrainsUseCase(ref.read(trainRepositoryProvider));
});
