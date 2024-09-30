import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/Providers/auth_provider.dart';
import 'package:mahattaty/Screens/root_screen.dart';
import 'package:mahattaty/Themes/dark_theme.dart';
import 'package:mahattaty/Utils/constant.dart';
import 'package:mahattaty/Utils/open_screens.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';

class SocialAccountsLogin extends ConsumerWidget {
  const SocialAccountsLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider.notifier);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MahattatyButton(
                text: 'Continue with Google',
                elevation: 1,
                onPressed: () async {
                  bool isLogined =
                      await authNotifier.submitLogin(isGoogleLogin: true);
                  if (isLogined) {
                    openScreen(
                      context: context,
                      routeName: const RootScreen().homeRouteName,
                      isReplace: true,
                    );
                  }
                },
                borderColor: colorScheme.onPrimaryContainer,
                style: MahattatyButtonStyle.secondary,
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                svgPicture: googleIcon,
                width: 150,
              ),
              const SizedBox(height: 10, width: 10),
              MahattatyButton(
                elevation: 1,
                text: 'Continue with Facebook',
                onPressed: () async {
                  bool isLogined =
                      await authNotifier.submitLogin(isFacebookLogin: true);
                  if (isLogined) {
                    openScreen(
                      context: context,
                      routeName: const RootScreen().homeRouteName,
                      isReplace: true,
                    );
                  }
                },
                borderColor: colorScheme.onPrimaryContainer,
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                style: MahattatyButtonStyle.secondary,
                svgPicture: facebookIcon,
                width: 150,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
