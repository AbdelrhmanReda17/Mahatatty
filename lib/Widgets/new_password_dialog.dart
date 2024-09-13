import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Screens/verification_screen.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';

void showNewPasswordDialog(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Theme.of(context).colorScheme.background,
    elevation: 0,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      TextEditingController passwordController = TextEditingController();
      TextEditingController confirmPasswordController = TextEditingController();
      return PopScope(
        onPopInvoked: (_) {
          passwordController.dispose();
          confirmPasswordController.dispose();
        },

        child: Padding(
          padding: const EdgeInsets.only(
              left: 30.0, right: 30.0, top: 20.0, bottom: 30.0),
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
                'Create new password ',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your new password and confirm it',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              const SizedBox(height: 35),
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
              const SizedBox(height: 45),
              MahattatyButton(
                text: 'Change Password',
                style: MahattatyButtonStyle.primary,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VerificationScreen(),
                    ),
                  );
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
