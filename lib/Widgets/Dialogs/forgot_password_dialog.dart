import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Utils/validate.dart';
import 'package:share/share.dart';
import '../../Providers/States/auth_state.dart';
import '../../Providers/auth_provider.dart';
import '../Generics/mahattaty_alert.dart';
import '../Generics/mahattaty_dialog.dart';
import '../Generics/mahattaty_text_form_field.dart';

class ForgetPasswordDialog extends ConsumerWidget {
  ForgetPasswordDialog({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider.notifier);
    final authState = ref.watch(authProvider);
    return PopScope(
      canPop: authState.error != null,
      onPopInvokedWithResult: (_,__) => authNotifier.resetError(),
      child: MahattatyDialog(
        title: 'Forget Password',
        description: 'Enter your email to reset your password',
        content: [
          MahattatyTextFormField(
            labelText: 'Email',
            iconData: FontAwesomeIcons.envelope,
            hintText: 'Enter your email',
            errorText: authState.error?.type == AuthErrorType.emailOrPhone && authState.error?.action == AuthAction.resetPassword
                ? authState.error?.message
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
          final result = await authNotifier.submitForgetPassword(
              email: emailController.text);
          if (result) {
            mahattatyAlertDialog(
              context,
              message:
              'An email has been sent to ${emailController
                  .text} to reset your password',
              type: MahattatyAlertType.success,
              onOk: () => Navigator.of(context).pop(),
              onPop: () => authNotifier.resetError(),
            );
          }
        },
      ),
    );
  }
}
