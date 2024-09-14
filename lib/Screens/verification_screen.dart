import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Widgets/Dialogs/register_success_dialog.dart';
import '../Widgets/Generics/mahattaty_button.dart';
import '../Widgets/Generics/mahattaty_circle_icon.dart';
import '../Widgets/Generics/mahattaty_text_form_field.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  bool isFirstTime = true;

  void _handlePaste() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null) {
      String pastedText = clipboardData.text ?? '';
      if (pastedText.length == 5) {
        for (int i = 0; i < 5; i++) {
          _controllers[i].text = pastedText[i];
        }
        setState(() {
          isFirstTime = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5.0),
              Container(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                height: 1.5,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        children: [
          const SizedBox(height: 40),
          // Icon at the top
          MahattatyCircleIcon(
            outerCircleColor: Theme.of(context).colorScheme.primary,
            innerCircleColor: Theme.of(context).colorScheme.primary,
            child: Stack(
              children: [
                Icon(
                  Icons.email,  // Main icon
                  size: 40,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.lock,  // Small lock icon
                      size: 13,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),


          const SizedBox(height: 40),
          Text(
            'Verification Code',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'We have sent the code verification to',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            'magdalena83@mail.com',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 40),
          _buildCodeInputs(context),
          const SizedBox(height: 55),
          MahattatyButton(
            style: MahattatyButtonStyle.primary,
            text: 'Submit',
            onPressed: () {
              //Navigator.of(context).pop();
              RegisterSuccessDialog(context);

            },
            textStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.surface),
            verticalPadding: 17.0,
            horizontalPadding: 20.0,
          ),
          const SizedBox(height: 30),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: "Didn't receive the code? ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
              children: [
                TextSpan(
                  text: 'Resend',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //resend code
                    },
                ),
              ],
            ),
          ),
        ],
      ),
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
            onTap: () {
              if (index == 0 &&
                  _controllers[index].text.isEmpty &&
                  isFirstTime) {
                _handlePaste();
              }
            },
          ),
        );
      }),
    );
  }
}
