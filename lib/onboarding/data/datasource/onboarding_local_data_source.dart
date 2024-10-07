import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/onboarding_step.dart';

class OnboardingLocalDataSource {
  static const String _onboardingSeenKey = 'onboarding_seen';

  List<OnboardingStepData> getOnboardingSteps() {
    return [
      OnboardingStepData(
        title: 'Welcome to Mahattaty',
        description:
            'Mahattaty is a platform that connects you with the best tutors in the country.',
        image: 'assets/images/onboarding1.png',
      ),
      OnboardingStepData(
        title: 'Find the best tutors',
        description:
            'Search for tutors based on your preferences and requirements.',
        image: 'assets/images/onboarding2.png',
      ),
      OnboardingStepData(
        title: 'Book a session',
        description:
            'Book a session with your preferred tutor and start learning.',
        image: 'assets/images/onboarding3.png',
      ),
    ];
  }

  Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingSeenKey) ?? false;
  }

  Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingSeenKey, true);
  }
}
