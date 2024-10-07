import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_onboarding_steps_usecase.dart';
import 'onboarding_provider.dart';

final getOnboardingStepsProvider = Provider((ref) {
  return GetOnboardingStepsUseCase(ref.watch(onboardingRepositoryProvider));
});
