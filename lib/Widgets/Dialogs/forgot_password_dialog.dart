import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Utils/open_dialog.dart';
import 'package:mahattaty/Widgets/Dialogs/otp_dialog.dart';
import '../Generics/mahattaty_dialog.dart';
import '../Generics/mahattaty_text_form_field.dart';

class ForgetPasswordDialog extends StatelessWidget {
  ForgetPasswordDialog({super.key});

  final TextEditingController emailController = TextEditingController();

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
      ],
      buttonText: 'Send Email',
      contentPlacement: ContentPlacement.afterTitle,
      onButtonPressed: () {
        Navigator.of(context).pop();
        openDialog(context: context, dialog: OTPDialog());
      },
    );
  }
}
