import 'package:flutter/material.dart';
import 'package:mahattaty/Utils/constant.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_onboarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  String get routeName => '/onboarding';

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              MahattatyOnboarding(
                onBoardingData: OnBoardingData(
                  image: onboardingScreenImage1,
                  title:
                      'Enjoy The Convenience Of Buying Tickets For Your Trip',
                  subtitle:
                      'Plan, book, and manage your journeys all in one place, effortlessly.',
                ),
                controller: _controller,
              ),
              MahattatyOnboarding(
                onBoardingData: OnBoardingData(
                  image: onboardingScreenImage2,
                  title: 'Easy To Get Train Tickets From Anywhere',
                  subtitle:
                      'Book tickets on the go, hassle-free, whether you\'re at home or on the move.',
                ),
                controller: _controller,
              ),
              MahattatyOnboarding(
                onBoardingData: OnBoardingData(
                  image: onboardingScreenImage3,
                  title: 'Access From Your Smartphone Anywhere',
                  subtitle:
                      'Stay connected with real-time updates and instant access to your bookings.',
                ),
                controller: _controller,
                isLastElement: true,
              ),
            ],
          ),
          Positioned(
            bottom: 350,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                onDotClicked: (index) {
                  _controller.animateToPage(
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
