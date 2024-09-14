import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Screens/verification_screen.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';
import '../Generics/mahattaty_dialog.dart';

void showNewPasswordDialog(BuildContext context) {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  showModalBottomSheet(
    backgroundColor: Theme.of(context).colorScheme.background,
    elevation: 0,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return MahattatyDialog(
        title: 'Create new password',
        description: 'Enter your new password and confirm it',
        content: [
          MahattatyTextFormField(
            labelText: 'Password',
            isPassword: true,
            iconData: FontAwesomeIcons.lock,
            hintText: 'Create your password',
            controller: passwordController,
          ),
          const SizedBox(height: 20),
          MahattatyTextFormField(
            labelText: 'Confirm Password',
            isPassword: true,
            iconData: FontAwesomeIcons.lock,
            controller: confirmPasswordController,
            hintText: 'Enter your password again',
          ),
        ],
        buttonText: 'Change Password',
        onButtonPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VerificationScreen(),
            ),
          );
        },
      );
    },
  );
}

