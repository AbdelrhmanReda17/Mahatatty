import '../entities/onboarding_step.dart';

abstract class BaseOnboardingRepository {
  List<OnboardingStepData> getOnboardingSteps();

  Future<void> setOnboardingSeen();

  Future<bool> hasSeenOnboarding();
}
