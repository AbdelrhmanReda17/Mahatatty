import 'package:mahattaty/onboarding/domain/repository/onboarding_repository.dart';
import '../entities/onboarding_step.dart';

class GetOnboardingStepsUseCase {
  final BaseOnboardingRepository repository;

  GetOnboardingStepsUseCase(this.repository);

  List<OnboardingStepData> execute() {
    return repository.getOnboardingSteps();
  }
}
