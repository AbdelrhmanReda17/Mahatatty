import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Providers/auth_provider.dart';
import 'package:mahattaty/Utils/open_dialog.dart';
import 'package:mahattaty/Utils/validate.dart';
import 'package:mahattaty/Widgets/Dialogs/otp_dialog.dart';
import '../Generics/mahattaty_dialog.dart';
import '../Generics/mahattaty_text_form_field.dart';

class ForgetPasswordDialog extends ConsumerWidget {
  ForgetPasswordDialog({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthNotifier authNotifier = ref.read(authProvider.notifier);
    return MahattatyDialog(
      title: 'Forget Password',
      description: 'Enter your email to reset your password',
      content: [
        MahattatyTextFormField(
          labelText: 'Email',
          iconData: FontAwesomeIcons.envelope,
          hintText: 'Enter your email',
          validator: (value) => value!.isValidEmail
              ? null
              : 'Invalid Input, Please enter a valid email or phone number',
          controller: emailController,
        ),
        const SizedBox(height: 10),
      ],
      buttonText: 'Send Email',
      contentPlacement: ContentPlacement.afterTitle,
      onButtonPressed: () {
        authNotifier.sendOTP(
          recipient: emailController.text,
          otp: '1234',
        );
        Navigator.of(context).pop();
        openDialog(context: context, dialog: OTPDialog());
      },
    );
  }
}
  // Future<void> _handlePasswordReset(BuildContext context, {bool isResend = false}) async {
  //   final email = emailController.text.trim();

  //   if (email.isEmpty) {
  //     mahattatyAlertDialog(
  //       context,
  //       message: 'Email cannot be empty',
  //       type: MahattatyAlertType.error,
  //       onOk: () => Navigator.of(context).pop(),
  //     );
  //     return;
  //   }

  //   try {
  //     await _firebaseAuth.sendPasswordResetEmail(email: email);

  //     mahattatyAlertDialog(
  //       context,
  //       message: isResend
  //           ? 'Resent password reset link to $email'
  //           : 'Password reset link sent to $email',
  //       type: MahattatyAlertType.success,
  //     );

  //     if (!emailSent) {
  //       setState(() {
  //         emailSent = true;
  //       });
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     mahattatyAlertDialog(
  //       context,
  //       message: e.message ?? 'Failed to send reset email',
  //       type: MahattatyAlertType.error,
  //     );
  //   }
  // }