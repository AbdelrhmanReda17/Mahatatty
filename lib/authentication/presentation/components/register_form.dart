import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/utils/validations.dart';
import '../../../core/generic components/mahattaty_button.dart';
import '../../../core/generic components/mahattaty_text_form_field.dart';
import '../../Exceptions/auth_exception.dart';

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
                labelText: 'Name',
                controller: _registerControllers[0],
                iconData: FontAwesomeIcons.user,
                hintText: 'Enter your name',
                validator: (value) => value!.isValidUsername
                    ? null
                    : 'Invalid Input , must be at least 3 characters',
                onChanged: (value) => _registerKeys[0].currentState!.validate(),
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                fieldKey: _registerKeys[1],
                labelText: 'Email',
                controller: _registerControllers[1],
                iconData: FontAwesomeIcons.envelope,
                hintText: 'Enter your email',
                errorText: authState.exception?.code ==
                            AuthErrorType.emailError &&
                        authState.exception?.action == AuthErrorAction.signUp
                    ? authState.exception?.message
                    : null,
                validator: (value) => value!.isValidPhoneOrEmail
                    ? null
                    : 'Invalid Input  , must be a valid email',
                onChanged: (value) => _registerKeys[1].currentState!.validate(),
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                fieldKey: _registerKeys[2],
                labelText: 'Password',
                controller: _registerControllers[2],
                isPassword: true,
                errorText: authState.exception?.code ==
                            AuthErrorType.passwordError &&
                        authState.exception?.action == AuthErrorAction.signUp
                    ? authState.exception?.message
                    : null,
                iconData: FontAwesomeIcons.lock,
                hintText: 'Create your password',
                validator: (value) => value!.isValidPassword
                    ? null
                    : 'Invalid Input , must be at least 8 characters With at least one uppercase letter, one lowercase letter',
                onChanged: (value) {
                  _registerKeys[2].currentState!.validate();
                  _registerKeys[3].currentState!.validate();
                },
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                fieldKey: _registerKeys[3],
                labelText: 'Confirm Password',
                controller: _registerControllers[3],
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                hintText: 'Confirm your password',
                validator: (value) =>
                    value!.isValidConfirmPassword(_registerControllers[2].text)
                        ? null
                        : 'Invalid Input , must be the same as the password',
                onChanged: (value) => _registerKeys[3].currentState!.validate(),
              ),
              const SizedBox(height: 20),
              MahattatyButton(
                text: 'Sign Up',
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
