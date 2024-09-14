import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';
import 'package:mahattaty/Widgets/Dialogs/forgot_password_dialog.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final List<TextEditingController> _loginControllers =
      List.generate(2, (_) => TextEditingController());

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MahattatyTextFormField(
            labelText: 'Email or Phone Number',
            controller: _loginControllers[0],
            iconData: FontAwesomeIcons.envelope,
            
            hintText: 'Enter your email or phone number',
          ),
          const SizedBox(height: 20),
          MahattatyTextFormField(
            labelText: 'Password',
            controller: _loginControllers[1],
            isPassword: true,
            iconData: FontAwesomeIcons.lock,
            hintText: 'Create your password',
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
        ],
      ),
    );
  }
}
