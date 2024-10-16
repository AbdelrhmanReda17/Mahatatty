import 'package:flutter/material.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import '../../../authentication/presentation/screens/authentication_screen.dart';
import '../../../core/generic components/mahattaty_button.dart';
import '../../domain/entities/onboarding_step.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingStep extends StatefulWidget {
  const OnboardingStep({
    super.key,
    required this.onBoardingStep,
    required this.controller,
    this.isLastElement = false,
  });

  final OnboardingStepData onBoardingStep;
  final bool? isLastElement;
  final PageController controller;

  @override
  State<OnboardingStep> createState() => _MahattatyOnboardingState();
}

class _MahattatyOnboardingState extends State<OnboardingStep>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimaryContainerColor =
        Theme.of(context).colorScheme.onPrimaryContainer;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge!;
    final headlineMedium = Theme.of(context).textTheme.headlineMedium!;

    return LayoutBuilder(
      builder: (context, constraints) {
        var nextButton = FloatingActionButton(
          tooltip: AppLocalizations.of(context)!.nextButton,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () {
            widget.controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        );
        var getStartedButton = SizedBox(
          width: constraints.maxWidth * 0.45,
          child: MahattatyButton(
            style: MahattatyButtonStyle.primary,
            backgroundColor: primaryColor,
            text: AppLocalizations.of(context)!.getStartedButton,
            onPressed: () {
              OpenScreen.open(
                context: context,
                screen: const AuthenticationScreen(),
                isReplace: true,
              );
            },
          ),
        );
        var loginButton = SizedBox(
          width: constraints.maxWidth * 0.45,
          child: MahattatyButton(
            style: MahattatyButtonStyle.secondary,
            text: AppLocalizations.of(context)!.signInButton,
            borderColor: primaryColor,
            textStyle: bodyLarge.copyWith(
              color: primaryColor,
            ),
            onPressed: () {
              OpenScreen.open(
                context: context,
                screen: const AuthenticationScreen(),
                isReplace: true,
              );
            },
          ),
        );
        var skipButton = TextButton(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            textStyle: bodyLarge.copyWith(
              color: primaryColor,
            ),
          ),
          onPressed: () {
            widget.controller.animateToPage(
              2,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: Text(AppLocalizations.of(context)!.skipButton),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              FadeTransition(
                opacity: _controller,
                child: Image.asset(
                  widget.onBoardingStep.image,
                  height: constraints.maxHeight * 0.56,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.onBoardingStep.title,
                textAlign: TextAlign.center,
                style: headlineMedium.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                widget.onBoardingStep.description,
                style: bodyLarge.copyWith(
                  color: onPrimaryContainerColor,
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!widget.isLastElement!) skipButton else loginButton,
                    if (widget.isLastElement!) getStartedButton else nextButton,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
