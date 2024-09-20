import 'package:flutter/material.dart';
import 'package:mahattaty/Utils/constant.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_onboarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  String get routeName => '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  title: 'Access From Your Smartphone Anywhere',
                  subtitle:
                      'Stay connected with real-time updates and instant access to your bookings.',
                ),
                controller: _controller,
              ),
              MahattatyOnboarding(
                onBoardingData: OnBoardingData(
                  image: onboardingScreenImage3,
                  title: 'Easy To Get Train Tickets From Anywhere',
                  subtitle:
                      'Book tickets on the go, hassle-free, whether you\'re at home or on the move.',
                ),
                controller: _controller,
              ),
            ],
          ),
          Positioned(
            bottom: 190, // Adjust this value as needed
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                  dotWidth: 7.5,
                  dotHeight: 7.5,
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
