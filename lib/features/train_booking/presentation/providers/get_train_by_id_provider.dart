import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/presentation/providers/train_provider.dart';

import '../../domain/entities/train.dart';

final getTrainByIdProvider = FutureProvider.family<Train, String>((ref, trainId) async {
  final repository = ref.read(trainRepositoryProvider);
  final train = await repository.getTrainById(trainId);
  return train;
});