import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/onboarding_local_data_source.dart';
import '../../data/repository/onboarding_repository.dart';
import '../../domain/repository/onboarding_repository.dart';

final onboardingRepositoryProvider = Provider<BaseOnboardingRepository>((ref) {
  final localDataSource = OnboardingLocalDataSource();
  return OnboardingRepository(localDataSource);
});
