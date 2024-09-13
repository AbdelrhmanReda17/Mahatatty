import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';
import 'package:mahattaty/Widgets/new_password_dialog.dart';

void showForgotPasswordDialog(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Theme.of(context).colorScheme.background,
    elevation: 0,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      TextEditingController emailController = TextEditingController();
      return PopScope(
        onPopInvoked: (_) => emailController.dispose(),
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(5.0),
                      right: Radius.circular(5.0),
                    ),
                  ),
                  width: 70,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Forgot Password',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your email or phone number',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                labelText: 'Email or Phone Number',
                iconData: FontAwesomeIcons.envelope,
                controller: emailController,
                hintText: 'Enter your email or phone number',
              ),
              const SizedBox(height: 45),
              MahattatyButton(
                text: 'Send Code',
                style: MahattatyButtonStyle.primary,
                onPressed: () {
                  Navigator.of(context).pop();
                  showNewPasswordDialog(context);
                },
                height: 50,
              ),
            ],
          ),
        ),
      );
    },
  );
}
