import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/check_onboarding_status_usecase.dart';

import 'onboarding_provider.dart';

final checkOnboardingStatusProvider = Provider((ref) {
  return CheckOnboardingStatusUseCase(ref.watch(onboardingRepositoryProvider));
});
