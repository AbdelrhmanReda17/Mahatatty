import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';
import 'package:mahattaty/Widgets/Dialogs/forgot_password_dialog.dart';
import 'package:mahattaty/Utils/validate.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final List<TextEditingController> _loginControllers =
      List.generate(2, (_) => TextEditingController());
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final List<GlobalKey<FormFieldState>> _loginKeys = List.generate(2, (_) => GlobalKey<FormFieldState>());

  @override
  void dispose() {
    for (var controller in _loginControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MahattatyTextFormField(
            fieldKey: _loginKeys[0],
            labelText: 'Email or Phone Number',
            controller: _loginControllers[0],
            iconData: FontAwesomeIcons.envelope,
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
            iconData: FontAwesomeIcons.lock,
            hintText: 'Create your password',
            validator: (value) => value!.isEmpty ? 'Password is required' : null,
            onChanged: (value) => _loginKeys[1].currentState!.validate(),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () => showForgotPasswordDialog(context),
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
            onPressed: () {
              if (!_loginFormKey.currentState!.validate() ||
                  _loginControllers[1].text.isEmpty) return;
              for (var controller in _loginControllers) {
                log(controller.text);
              }
            },
            height: 50,
          ),
        ],
      ),
    );
  }
}
