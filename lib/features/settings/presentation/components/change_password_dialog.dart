import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_text_form_field.dart';
import 'package:mahattaty/core/utils/validations.dart';
import '../../../../core/generic components/mahattaty_dialog.dart';

class ChangePasswordDialog extends StatelessWidget {
  final _passwordFormKey = GlobalKey<FormState>();

  ChangePasswordDialog({
    super.key,
    required this.onButtonPressed,
  });

  final List<TextEditingController> passwordTextControllers =
      List.generate(2, (_) => TextEditingController());

  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return MahattatyDialog(
      title: 'Create new password',
      description: 'Enter your new password and confirm it',
      content: [
        Form(
          key: _passwordFormKey,
          child: Column(
            children: [
              MahattatyTextFormField(
                labelText: 'Password',
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                hintText: 'Create your password',
                controller: passwordTextControllers[0],
                validator: (value) => value!.isValidPassword
                    ? null
                    : 'Password must be at least 8 characters, include an uppercase letter, a lowercase letter, and a number',
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                labelText: 'Confirm Password',
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                controller: passwordTextControllers[1],
                hintText: 'Enter your password again',
                validator: (value) => value!
                        .isValidConfirmPassword(passwordTextControllers[0].text)
                    ? null
                    : 'Passwords do not match',
              ),
            ],
          ),
        ),
      ],
      buttonText: 'Change Password',
      onButtonPressed: () {
        if (_passwordFormKey.currentState!.validate()) {
          onButtonPressed(passwordTextControllers[0].text);
        }
      },
    );
  }
}
