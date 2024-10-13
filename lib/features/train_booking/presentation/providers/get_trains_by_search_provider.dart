import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/presentation/providers/train_provider.dart';

import '../../domain/usecases/get_train_by_search_usecase.dart';

final getTrainsBySearchUseCaseProvider = Provider<GetTrainsBySearch>((ref) {
  return GetTrainsBySearch(ref.read(trainRepositoryProvider));
});
