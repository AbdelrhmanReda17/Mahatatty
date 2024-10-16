import '../entities/onboarding_step.dart';
import 'package:flutter/material.dart';

abstract class BaseOnboardingRepository {
  List<OnboardingStepData> getOnboardingSteps(BuildContext context);

  Future<void> setOnboardingSeen();

  Future<bool> hasSeenOnboarding();
}
