import 'package:mahattaty/onboarding/domain/repository/onboarding_repository.dart';

class SetOnboardingSeenUseCase {
  final BaseOnboardingRepository repository;

  SetOnboardingSeenUseCase(this.repository);

  Future<void> execute() {
    return repository.setOnboardingSeen();
  }
}
