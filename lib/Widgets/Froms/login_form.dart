import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Providers/States/auth_state.dart';
import 'package:mahattaty/Providers/auth_provider.dart';
import 'package:mahattaty/Screens/temp_screen.dart';
import 'package:mahattaty/Utils/open_screens.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';
import 'package:mahattaty/Widgets/Dialogs/forgot_password_dialog.dart';
import 'package:mahattaty/Utils/validate.dart';
import 'package:mahattaty/Utils/open_dialog.dart';

class LoginForm extends ConsumerWidget {
  LoginForm({super.key});

  final List<TextEditingController> _loginControllers =
      List.generate(2, (_) => TextEditingController());

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final List<GlobalKey<FormFieldState>> _loginKeys =
      List.generate(2, (_) => GlobalKey<FormFieldState>());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    log(authState.toString());

    return Form(
      onPopInvoked: (_) {
        log('Clearing Errors');

        authNotifier.clearErrors();
      },
      key: _loginFormKey,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MahattatyTextFormField(
              fieldKey: _loginKeys[0],
              labelText: 'Email or Phone Number',
              controller: _loginControllers[0],
              iconData: FontAwesomeIcons.envelope,
              errorText: authState.error?.type == AuthErrorType.emailOrPhone
                  ? authState.error?.message
                  : null,
              validator: (value) => value!.isValidPhoneOrEmail
                  ? null
                  : 'Invalid Input, Please enter a valid email or phone number',
              onChanged: (value) => _loginKeys[0].currentState!.validate(),
              hintText: 'Enter your email or phone number',
            ),
            const SizedBox(height: 20),
            MahattatyTextFormField(
              fieldKey: _loginKeys[1],
              labelText: 'Password',
              controller: _loginControllers[1],
              isPassword: true,
              errorText: authState.error?.type == AuthErrorType.password
                  ? authState.error?.message
                  : null,
              iconData: FontAwesomeIcons.lock,
              hintText: 'Create your password',
              validator: (value) =>
                  value!.isEmpty ? 'Password is required' : null,
              onChanged: (value) => _loginKeys[1].currentState!.validate(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => openDialog(
                    context: context,
                    dialog: ForgetPasswordDialog(),
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            MahattatyButton(
              text: 'Sign In',
              style: MahattatyButtonStyle.primary,
              disabled: authState.isLoading,
              onPressed: () {
                if (_loginFormKey.currentState!.validate()) {
                  authNotifier.submitLogin(
                    emailOrPhone: _loginControllers[0].text,
                    password: _loginControllers[1].text,
                  );
                }
              },
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
