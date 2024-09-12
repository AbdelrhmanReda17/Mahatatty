import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';

class SocialAccountsLogin extends StatelessWidget {
  const SocialAccountsLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isLargeScreen = constraints.maxWidth > 500;
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Or using other methods',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              const SizedBox(height: 15),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MahattatyButton(
                    text: 'Google',
                    onPressed: () {},
                    style: MahattatyButtonStyle.secondary,
                    width: isLargeScreen ? constraints.maxWidth : 0,
                    iconData: FontAwesomeIcons.google,
                  ),
                  const SizedBox(height: 10, width: 10),
                  MahattatyButton(
                    text: 'Facebook',
                    onPressed: () {},
                    style: MahattatyButtonStyle.secondary,
                    width: isLargeScreen ? constraints.maxWidth : 0,
                    iconData: FontAwesomeIcons.facebook,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
