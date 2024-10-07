import 'package:mahattaty/onboarding/domain/repository/onboarding_repository.dart';

class CheckOnboardingStatusUseCase {
  final BaseOnboardingRepository repository;

  CheckOnboardingStatusUseCase(this.repository);

  Future<bool> execute() {
    return repository.hasSeenOnboarding();
  }
}
