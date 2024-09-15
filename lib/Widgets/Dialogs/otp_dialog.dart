import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Utils/open_dialog.dart';
import 'package:mahattaty/Widgets/Dialogs/forgot_password_dialog.dart';
import 'package:mahattaty/Widgets/Dialogs/new_password_dialog.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_dialog.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';

class OTPDialog extends StatelessWidget {
  OTPDialog({super.key});
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    return MahattatyDialog(
      title: 'Verification',
      description:
          'Enter the OTP sent to your email or phone number to verify your account',
      content: [
        _buildCodeInputs(context),
        const SizedBox(height: 20),
        Center(
          child: RichText(
            text: TextSpan(
              text: "Didn't receive the code? ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
              children: [
                TextSpan(
                  text: 'Resend',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        MahattatyButton(
          text: 'Change Email',
          onPressed: () {
            Navigator.of(context).pop();
            openDialog(context: context, dialog: ForgetPasswordDialog());
          },
          iconData: FontAwesomeIcons.envelope,
          style: MahattatyButtonStyle.secondary,
        ),
      ],
      buttonText: 'Verify',
      textAlign: TextAlign.center,
      onButtonPressed: () {
        Navigator.of(context).pop();
        openDialog(context: context, dialog: NewPasswordDialog());
      },
      contentPlacement: ContentPlacement.afterTitle,
    );
  }

  Widget _buildCodeInputs(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        return SizedBox(
          width: 72,
          height: 80,
          child: MahattatyTextFormField(
            controller: _controllers[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            textStyle: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        );
      }),
    );
  }
}
