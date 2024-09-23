import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Utils/open_dialog.dart';
import 'package:mahattaty/Utils/validate.dart';
import 'package:mahattaty/Widgets/Dialogs/notification_dialog.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';
import '../Generics/mahattaty_alert.dart';
import '../Generics/mahattaty_dialog.dart';

class NewPasswordDialog extends StatelessWidget {
  NewPasswordDialog({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MahattatyDialog(
      title: 'Create new password',
      description: 'Enter your new password and confirm it',
      content: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              MahattatyTextFormField(
                labelText: 'Password',
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                hintText: 'Create your password',
                controller: passwordController,
                validator: (value) => value!.isValidPassword
                    ? null
                    : 'Password must be at least 8 characters, include an uppercase letter, a lowercase letter, and a number',
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                labelText: 'Confirm Password',
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                controller: confirmPasswordController,
                hintText: 'Enter your password again',
                validator: (value) => value!.isValidConfirmPassword(passwordController.text)
                    ? null
                    : 'Passwords do not match',
              ),
            ],
          ),
        ),
      ],
      buttonText: 'Change Password',
      onButtonPressed: () async{
        if (!_formKey.currentState!.validate()) {
          return;
        }
        final newPassword = passwordController.text.trim();
        final confirmPassword = confirmPasswordController.text.trim();

        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await user.updatePassword(newPassword);
            mahattatyAlertDialog(
              context,
              message: 'Your password has been changed successfully.',
              type: MahattatyAlertType.success,
              onOk: () {
                Navigator.of(context).pop();
              },
            );
          }
        } catch (e) {
          mahattatyAlertDialog(
            context,
            message: 'Failed to change password. Please try again.',
            type: MahattatyAlertType.error,
          );
        }
      },
    );
  }
}
