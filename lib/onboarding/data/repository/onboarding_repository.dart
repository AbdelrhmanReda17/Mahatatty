import 'package:flutter/cupertino.dart';
import 'package:mahattaty/onboarding/domain/repository/onboarding_repository.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/onboarding_step.dart';
import '../datasource/onboarding_local_data_source.dart';

class OnboardingRepository implements BaseOnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepository(this.localDataSource);

  @override
  List<OnboardingStepData> getOnboardingSteps(BuildContext context) {
    return localDataSource.getOnboardingSteps(context);
  }

  @override
  Future<bool> hasSeenOnboarding() {
    return localDataSource.hasSeenOnboarding();
  }

  @override
  Future<void> setOnboardingSeen() {
    return localDataSource.setOnboardingSeen();
  }
}
