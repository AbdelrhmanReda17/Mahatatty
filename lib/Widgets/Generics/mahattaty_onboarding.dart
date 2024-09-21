import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mahattaty/Screens/authentication_screen.dart';
import 'package:mahattaty/Utils/open_screens.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';

class OnBoardingData {
  final String image;
  final String title;
  final String subtitle;

  OnBoardingData({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class MahattatyOnboarding extends StatefulWidget {
  MahattatyOnboarding({
    super.key,
    required this.onBoardingData,
    required this.controller,
    this.isLastElement = false,
  });

  final OnBoardingData onBoardingData;
  bool? isLastElement;
  final PageController controller;
  @override
  State<MahattatyOnboarding> createState() => _MahattatyOnboardingState();
}

class _MahattatyOnboardingState extends State<MahattatyOnboarding>
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
    return LayoutBuilder(
      builder: (context, constraints) {
        var nextButton = FloatingActionButton(
          tooltip: 'Next',
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () {
            widget.controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          child: const Icon(Icons.arrow_forward),
        );

        var getStartedButton = SizedBox(
          width: constraints.maxWidth * 0.45,
          child: MahattatyButton(
            style: MahattatyButtonStyle.primary,
            backgroundColor: Theme.of(context).colorScheme.primary,
            text: 'Get Started',
            onPressed: () {
              openScreen(
                context: context,
                routeName: const AuthenticationScreen().registerRouteName,
                isReplace: true,
              );
            },
          ),
        );
        var loginButton = SizedBox(
          width: constraints.maxWidth * 0.45,
          child: MahattatyButton(
            style: MahattatyButtonStyle.secondary,
            text: 'Login',
            borderColor: Theme.of(context).colorScheme.primary,
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
            onPressed: () {
              openScreen(
                context: context,
                routeName: const AuthenticationScreen().loginRouteName,
                isReplace: true,
              );
            },
          ),
        );
        var skipButton = TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          onPressed: () {
            widget.controller.animateToPage(
              2,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: const Text('Skip'),
        );
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            FadeTransition(
              opacity: _controller,
              child: Image.asset(
                widget.onBoardingData.image,
                height: constraints.maxHeight * 0.56,
              ),
            ),
            FadeTransition(
              opacity: _controller,
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.08),
                  Text(
                    widget.onBoardingData.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    textAlign: TextAlign.center,
                    widget.onBoardingData.subtitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  Align(
                    widthFactor: 1,
                    heightFactor: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!widget.isLastElement!) skipButton else loginButton,
                        if (widget.isLastElement!)
                          getStartedButton
                        else
                          nextButton,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
