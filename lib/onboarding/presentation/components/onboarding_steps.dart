import 'package:flutter/cupertino.dart';

import '../../domain/entities/onboarding_step.dart';
import 'onboarding_step.dart';

class OnBoardingSteps extends StatelessWidget {
  const OnBoardingSteps(
      {super.key, required this.steps, required this.controller});

  final List<OnboardingStepData> steps;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: [
        for (final step in steps)
          OnboardingStep(
            onBoardingStep: step,
            controller: controller,
            isLastElement: steps.last == step,
          ),
      ],
    );
  }
}
