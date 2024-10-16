import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/utils/validations.dart';
import '../../../core/generic components/mahattaty_button.dart';
import '../../../core/generic components/mahattaty_text_form_field.dart';
import '../../Exceptions/auth_exception.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'form_error.dart';

class RegisterForm extends ConsumerWidget {
  RegisterForm({super.key});

  final List<TextEditingController> _registerControllers =
      List.generate(4, (_) => TextEditingController());
  final List<GlobalKey<FormFieldState>> _registerKeys =
      List.generate(4, (_) => GlobalKey<FormFieldState>());
  final GlobalKey<FormState> _registerFromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final authNotifier = ref.read(authControllerProvider.notifier);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Form(
          key: _registerFromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MahattatyTextFormField(
                fieldKey: _registerKeys[0],
                labelText: AppLocalizations.of(context)!.usernameLabel,
                controller: _registerControllers[0],
                iconData: FontAwesomeIcons.user,
                hintText: AppLocalizations.of(context)!.usernameHint,
                validator: (value) => value!.isValidUsername
                    ? null
                    : AppLocalizations.of(context)!.usernameError,
                onChanged: (value) => _registerKeys[0].currentState!.validate(),
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                fieldKey: _registerKeys[1],
                labelText: AppLocalizations.of(context)!.emailLabel,
                controller: _registerControllers[1],
                iconData: FontAwesomeIcons.envelope,
                hintText: AppLocalizations.of(context)!.emailHint,
                validator: (value) => value!.isValidEmail
                    ? null
                    : AppLocalizations.of(context)!.emailError,
                onChanged: (value) => _registerKeys[1].currentState!.validate(),
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                fieldKey: _registerKeys[2],
                labelText: AppLocalizations.of(context)!.passwordLabel,
                controller: _registerControllers[2],
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                hintText: AppLocalizations.of(context)!.passwordHint,
                validator: (value) => value!.isValidPassword
                    ? null
                    : AppLocalizations.of(context)!.passwordError,
                onChanged: (value) {
                  _registerKeys[2].currentState!.validate();
                  _registerKeys[3].currentState!.validate();
                },
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                fieldKey: _registerKeys[3],
                labelText: AppLocalizations.of(context)!.confirmPasswordLabel,
                controller: _registerControllers[3],
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                hintText: AppLocalizations.of(context)!.confirmPasswordHint,
                validator: (value) =>
                    value!.isValidConfirmPassword(_registerControllers[2].text)
                        ? null
                        : AppLocalizations.of(context)!.confirmPasswordError,
                onChanged: (value) => _registerKeys[3].currentState!.validate(),
              ),
              const SizedBox(height: 20),
              FormError(
                isShow: (authState.exception != null &&
                    authState.exception!.code != AuthErrorType.unknownError &&
                    authState.exception!.action == AuthErrorAction.signUp),
                message: authState.exception != null
                    ? AppLocalizations.of(context)!.registerError
                    : '',
              ),
              const SizedBox(height: 5),
              MahattatyButton(
                text: AppLocalizations.of(context)!.signUpButton,
                style: MahattatyButtonStyle.primary,
                disabled: authState.isLoading,
                onPressed: () async {
                  if (_registerFromKey.currentState!.validate()) {
                    await authNotifier.signUp(
                      _registerControllers[0].text,
                      _registerControllers[1].text,
                      _registerControllers[2].text,
                    );
                  }
                },
                height: 60,
              ),
            ],
          ),
        );
      },
    );
  }
}
