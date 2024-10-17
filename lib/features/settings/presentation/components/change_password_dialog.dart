import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/core/utils/validations.dart';
import '../../../../core/generic components/mahattaty_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/generic components/mahattaty_text_form_field.dart';
import '../controllers/settings_controller.dart';

class ChangePasswordDialog extends ConsumerWidget {
  final _passwordFormKey = GlobalKey<FormState>();

  ChangePasswordDialog({
    super.key,
    required this.onButtonPressed,
  });

  final List<TextEditingController> passwordTextControllers =
      List.generate(2, (_) => TextEditingController());

  final Function onButtonPressed;

  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    final isLoading = ref.watch(settingsControllerProvider).isLoading;
    return MahattatyDialog(
      title: AppLocalizations.of(context)!.changePassword,
      description: AppLocalizations.of(context)!.changePasswordDescription,
      disabled: isLoading,
      content: [
        Form(
          key: _passwordFormKey,
          child: Column(
            children: [
              MahattatyTextFormField(
                labelText: AppLocalizations.of(context)!.passwordLabel,
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                hintText: AppLocalizations.of(context)!.passwordHint,
                controller: passwordTextControllers[0],
                validator: (value) => value!.isValidPassword
                    ? null
                    : AppLocalizations.of(context)!.passwordError,
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                labelText: AppLocalizations.of(context)!.confirmPasswordLabel,
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                controller: passwordTextControllers[1],
                hintText: AppLocalizations.of(context)!.confirmPasswordHint,
                validator: (value) => value!
                        .isValidConfirmPassword(passwordTextControllers[0].text)
                    ? null
                    : AppLocalizations.of(context)!.confirmPasswordError,
              ),
            ],
          ),
        ),
      ],
      buttonText: AppLocalizations.of(context)!.changePassword,
      onButtonPressed: () async{
        if (_passwordFormKey.currentState!.validate()) {
          onButtonPressed(passwordTextControllers[0].text);
        }
      },
    );
  }
}
