import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/utils/validations.dart';

import '../../../../core/generic components/mahattaty_alert.dart';
import '../../../../core/generic components/mahattaty_dialog.dart';
import '../../../../core/generic components/mahattaty_text_form_field.dart';
import '../../../Exceptions/auth_exception.dart';

class ForgetPassword extends ConsumerWidget {
  ForgetPassword({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, __) =>
          authState.exception != null ? authNotifier.clearException() : null,
      child: MahattatyDialog(
        title: 'Forget Password',
        description: 'Enter your email to reset your password',
        content: [
          MahattatyTextFormField(
            labelText: 'Email',
            iconData: FontAwesomeIcons.envelope,
            hintText: 'Enter your email',
            errorText: authState.exception?.code == AuthErrorType.emailError
                ? authState.exception?.message
                : null,
            validator: (value) => value!.isValidEmail
                ? null
                : 'Invalid Input, Please enter a valid email or phone number',
            controller: emailController,
          ),
          const SizedBox(height: 10),
        ],
        buttonText: 'Send Email',
        contentPlacement: ContentPlacement.afterTitle,
        disabled: authState.isLoading,
        onButtonPressed: () async {
          final result =
              await authNotifier.forgetPassword(emailController.text);
          if (result) {
            mahattatyAlertDialog(
              context,
              message:
                  'An email has been sent to ${emailController.text} to reset your password',
              type: MahattatyAlertType.success,
              onOk: () => Navigator.of(context).pop(),
            );
          }
        },
      ),
    );
  }
}
