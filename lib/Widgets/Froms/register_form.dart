import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Providers/States/auth_state.dart';
import 'package:mahattaty/Providers/auth_provider.dart';
import 'package:mahattaty/Screens/temp_screen.dart';
import 'package:mahattaty/Utils/open_screens.dart';
import 'package:mahattaty/Utils/validate.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_alert.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends ConsumerState<RegisterForm> {
  final List<TextEditingController> _registerControllers =
      List.generate(4, (_) => TextEditingController());
  final List<GlobalKey<FormFieldState>> _registerKeys =
      List.generate(4, (_) => GlobalKey<FormFieldState>());
  final GlobalKey<FormState> _registerFromKey = GlobalKey<FormState>();

  bool isAcceptTerms = false;
  void _handleCheckBox(bool? value) {
    if (value == null) return;
    setState(() {
      isAcceptTerms = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    log(authState.toString());
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Form(
          onPopInvoked: (_) {
            log('Clearing Errors');
            authNotifier.clearErrors();
          },
          key: _registerFromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MahattatyTextFormField(
                fieldKey: _registerKeys[0],
                labelText: 'Full Name',
                controller: _registerControllers[0],
                iconData: FontAwesomeIcons.user,
                hintText: 'Enter your Full Name',
                validator: (value) => value!.isValidUsername
                    ? null
                    : 'Invalid Input , must be at least 3 characters',
                onChanged: (value) => _registerKeys[0].currentState!.validate(),
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                fieldKey: _registerKeys[1],
                labelText: 'Email or Phone Number',
                controller: _registerControllers[1],
                iconData: FontAwesomeIcons.envelope,
                hintText: 'Enter your email or phone number',
                errorText: authState.error?.type == AuthErrorType.emailOrPhone
                    ? authState.error?.message
                    : null,
                validator: (value) => value!.isValidPhoneOrEmail
                    ? null
                    : 'Invalid Input  , must be a valid email or phone number',
                onChanged: (value) => _registerKeys[1].currentState!.validate(),
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                fieldKey: _registerKeys[2],
                labelText: 'Password',
                controller: _registerControllers[2],
                isPassword: true,
                errorText: authState.error?.type == AuthErrorType.password
                    ? authState.error?.message
                    : null,
                iconData: FontAwesomeIcons.lock,
                hintText: 'Create your password',
                validator: (value) => value!.isValidPassword
                    ? null
                    : 'Invalid Input , must be at least 8 characters With at least one uppercase letter, one lowercase letter',
                onChanged: (value) => _registerKeys[2].currentState!.validate(),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isAcceptTerms,
                    onChanged: _handleCheckBox,
                  ),
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'I accept the ',
                        style: Theme.of(context).textTheme.titleSmall,
                        children: [
                          TextSpan(
                            text: 'Terms & Conditions & Privacy\nPolicy',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.apply(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          TextSpan(
                            text: ' set out by Mahattaty',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              const SizedBox(height: 20),
              MahattatyButton(
                text: 'Sign Up',
                style: MahattatyButtonStyle.primary,
                disabled: authState.isLoading,
                onPressed: () {
                  if (!_registerFromKey.currentState!.validate() ||
                      !isAcceptTerms) return;
                  authNotifier.submitRegister(
                    name: _registerControllers[0].text,
                    email: _registerControllers[1].text,
                    password: _registerControllers[2].text,
                  );
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
