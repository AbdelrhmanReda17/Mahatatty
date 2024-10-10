import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/train_booking/domain/usecases/get_user_booked_trains_usecase.dart';
import 'package:mahattaty/features/train_booking/presentation/providers/train_provider.dart';

final getUserBookedTrainsProvider = Provider<GetUserBookedTrainsUseCase>((ref) {
  return GetUserBookedTrainsUseCase(ref.read(trainRepositoryProvider));
});
