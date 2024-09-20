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

class MahattatyOnboarding extends StatelessWidget {
  const MahattatyOnboarding({
    super.key,
    required this.onBoardingData,
    required this.controller,
  });

  final OnBoardingData onBoardingData;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          onBoardingData.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          bottom: 0,
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: BottomSheet(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            onClosing: () {},
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      onBoardingData.title,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      onBoardingData.subtitle,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 30),
                    MahattatyButton(
                      text: 'Create Account',
                      style: MahattatyButtonStyle.primary,
                      onPressed: () {
                        openScreen(
                          context: context,
                          routeName: const AuthenticationScreen(
                            key: Key("register_screen"),
                          ).registerRouteName,
                          isReplace: true,
                        );
                      },
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                              ),
                      iconData: Icons.arrow_forward,
                      iconPosition: MahattatyIconPosition.end,
                      width: 130,
                      height: 70,
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                openScreen(
                                  context: context,
                                  routeName: const AuthenticationScreen()
                                      .loginRouteName,
                                  isReplace: true,
                                );
                              },
                            text: 'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
