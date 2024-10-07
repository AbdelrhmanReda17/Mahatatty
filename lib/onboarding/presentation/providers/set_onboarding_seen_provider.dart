import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/set_onboarding_seen_usecase.dart';
import 'onboarding_provider.dart';

final setOnboardingSeenProvider = Provider((ref) {
  return SetOnboardingSeenUseCase(ref.watch(onboardingRepositoryProvider));
});
