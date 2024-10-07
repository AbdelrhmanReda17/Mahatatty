import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/utils/app_constance.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import '../../../core/generic components/mahattaty_button.dart';
import '../../../core/screens/root_screen.dart';
import '../controllers/auth_controller.dart';

class SocialAccountsLogin extends ConsumerWidget {
  const SocialAccountsLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authControllerProvider.notifier);

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
          const SizedBox(height: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MahattatyButton(
                text: 'Continue with Google',
                elevation: 1,
                onPressed: () async {
                  await authNotifier.signIn('', '', true);
                },
                borderColor: Theme.of(context).colorScheme.onPrimaryContainer,
                style: MahattatyButtonStyle.secondary,
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                svgPicture: AppConstance.googleIcon,
                width: 150,
              ),
              const SizedBox(height: 8, width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
