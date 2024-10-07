import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/onboarding/domain/entities/onboarding_step.dart';
import '../components/onboarding_steps.dart';
import '../providers/get_onboarding_steps_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  String get routeName => '/onboarding';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = PageController();
    final List<OnboardingStepData> onboardingSteps =
        ref.watch(getOnboardingStepsProvider).execute();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          OnBoardingSteps(
            controller: controller,
            steps: onboardingSteps,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: onboardingSteps.length,
                onDotClicked: (index) {
                  controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                effect: ExpandingDotsEffect(
                  dotColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotHeight: 7.5,
                  dotWidth: 7.5,
                  expansionFactor: 4.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
