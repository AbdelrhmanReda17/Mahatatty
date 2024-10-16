import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/core/utils/app_constance.dart';
import '../../../core/generic components/mahattaty_button.dart';
import '../controllers/auth_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SocialAccountsLogin extends ConsumerWidget {
  const SocialAccountsLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authControllerProvider.notifier);
    final onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge!;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            AppLocalizations.of(context)!.orUsingOtherMethods,
            style: bodyLarge.copyWith(color: onPrimaryContainer),
          ),
          const SizedBox(height: 8),
          MahattatyButton(
            text: AppLocalizations.of(context)!.continueWithGoogle,
            elevation: 0,
            onPressed: () async {
              await authNotifier.signIn('', '', true);
            },
            borderColor: onPrimaryContainer,
            style: MahattatyButtonStyle.secondary,
            textStyle: bodyLarge.copyWith(fontWeight: FontWeight.w500),
            svgPicture: AppConstance.googleIcon,
            width: 150,
          ),
        ],
      ),
    );
  }
}
