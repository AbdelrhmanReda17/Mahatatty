import 'package:flutter/cupertino.dart';
import 'package:mahattaty/core/utils/app_constance.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/onboarding_step.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingLocalDataSource {
  static const String _onboardingSeenKey = 'onboarding_seen';

  List<OnboardingStepData> getOnboardingSteps(BuildContext context) {
    return [
      OnboardingStepData(
        title: AppLocalizations.of(context)!.onboardingTitle1,
        description: AppLocalizations.of(context)!.onboardingSubtitle1,
        image: AppConstance.onboardingImage1,
      ),
      OnboardingStepData(
        title: AppLocalizations.of(context)!.onboardingTitle2,
        description: AppLocalizations.of(context)!.onboardingSubtitle2,
        image: AppConstance.onboardingImage2,
      ),
      OnboardingStepData(
        title: AppLocalizations.of(context)!.onboardingTitle3,
        description: AppLocalizations.of(context)!.onboardingSubtitle3,
        image: AppConstance.onboardingImage3,
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
