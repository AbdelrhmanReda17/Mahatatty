import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Utils/open_dialog.dart';
import 'package:mahattaty/Widgets/Dialogs/notification_dialog.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';
import '../Generics/mahattaty_dialog.dart';

class NewPasswordDialog extends StatelessWidget {
  NewPasswordDialog({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        Navigator.of(context).pop();
        openDialog(
          context: context,
          dialog: const NotificationDialog(
            title: 'Password Changed',
            description:
                'Your password has been changed successfully, you can now login with your new password',
            icon: FontAwesomeIcons.solidCircleCheck,
            buttonText: 'Continue to Login',
            type: NotificationType.success,
          ),
        );
      },
    );
  }
}
