import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Generics/mahattaty_dialog.dart';
import '../Generics/mahattaty_text_form_field.dart';
import 'new_password_dialog.dart';

void showForgotPasswordDialog(BuildContext context) {
  TextEditingController emailController = TextEditingController();

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
        title: 'Forgot Password',
        description: 'Enter your email or phone number',
        content: [
          MahattatyTextFormField(
            labelText: 'Email or Phone Number',
            iconData: FontAwesomeIcons.envelope,
            controller: emailController,
            hintText: 'Enter your email or phone number',
          ),
        ],
        buttonText: 'Send Code',
        onButtonPressed: () {
          Navigator.of(context).pop();
          showNewPasswordDialog(context);
        },
      );
    },
  );
}
