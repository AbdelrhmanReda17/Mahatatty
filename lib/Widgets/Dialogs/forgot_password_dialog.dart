import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Utils/open_dialog.dart';
import 'package:mahattaty/Widgets/Dialogs/otp_dialog.dart';
import '../Generics/mahattaty_alert.dart';
import '../Generics/mahattaty_dialog.dart';
import '../Generics/mahattaty_text_form_field.dart';
import 'new_password_dialog.dart';

class ForgetPasswordDialog extends StatefulWidget {
  const ForgetPasswordDialog({super.key});

  @override
  State<ForgetPasswordDialog> createState() => _ForgetPasswordDialogState();
}

class _ForgetPasswordDialogState extends State<ForgetPasswordDialog> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool emailSent = false;

  @override
  Widget build(BuildContext context) {
    return MahattatyDialog(
      title: 'Forget Password',
      description: 'Enter your email to reset your password',
      content: [
        MahattatyTextFormField(
          labelText: 'Email',
          iconData: FontAwesomeIcons.envelope,
          hintText: 'Enter your email',
          controller: emailController,
        ),
        const SizedBox(height: 10),
        if (emailSent)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (emailSent)
                RichText(
                  text: TextSpan(
                    text: 'Didn\'t receive an email? ',
                    style: const TextStyle(color: Colors.red),
                    children: [
                      TextSpan(
                        text: 'Resend Email',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _handlePasswordReset(context, isResend: true),
                      ),
                    ],
                  ),
                ),

            ],
          ),
        const SizedBox(height: 10),
      ],
      buttonText: 'Send Email',
      contentPlacement: ContentPlacement.afterTitle,
      onButtonPressed: () { _handlePasswordReset(context);
      Navigator.of(context).pop();
      openDialog(context: context, dialog:  NewPasswordDialog());
      }
    );
  }

  Future<void> _handlePasswordReset(BuildContext context, {bool isResend = false}) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      mahattatyAlertDialog(
        context,
        message: 'Email cannot be empty',
        type: MahattatyAlertType.error,
        onOk: () => Navigator.of(context).pop(),
      );
      return;
    }

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

      mahattatyAlertDialog(
        context,
        message: isResend
            ? 'Resent password reset link to $email'
            : 'Password reset link sent to $email',
        type: MahattatyAlertType.success,
      );

      if (!emailSent) {
        setState(() {
          emailSent = true;
        });
      }
    } on FirebaseAuthException catch (e) {
      mahattatyAlertDialog(
        context,
        message: e.message ?? 'Failed to send reset email',
        type: MahattatyAlertType.error,
      );
    }
  }
}
