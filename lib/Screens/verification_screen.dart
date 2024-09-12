import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Themes/light_theme.dart';
import '../Widgets/Generics/mahattaty_button.dart';
import '../Widgets/Generics/mahattaty_text_form_field.dart';

class VerificationScreen extends StatefulWidget {
  //final String email;

  const VerificationScreen({super.key});
//  VerificationCodePage({required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  //  code inputs
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();
  final TextEditingController _fifthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Verification',style:  Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),),
        centerTitle: true,

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5.0), // Space between title and line
              Container(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                height: 1.5, // Thickness of the line
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Icon at the top
            Center(
              child: Stack(
                alignment: Alignment.center,

                children: [
                  // Outer circle with low opacity
                  CircleAvatar(
                    radius: 78,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.16), // Low opacity background
                  ),

                  // Inner circle with lock icon
                  CircleAvatar(
                    radius: 55,
                    backgroundColor:  Theme.of(context).colorScheme.primary, // Background for the lock icon
                    child: Stack(
                      children: [
                        Icon(
                          Icons.email,
                          size: 40,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 9, // Size of the lock icon's  circle
                            backgroundColor:  Theme.of(context).colorScheme.primary, // it is Background
                            child: Icon(
                              FontAwesomeIcons.lock,
                              size: 13,
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Title
            Text(
              'Verification Code',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Subtitle with email
            Text(
              'We have sent the code verification to',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: customGrey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
             //email,
              'magdalena83@mail.com',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),

            // Input fields for the code
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCodeInputField(_firstController),
                _buildCodeInputField(_secondController),
                _buildCodeInputField(_thirdController),
                _buildCodeInputField(_fourthController),
                _buildCodeInputField(_fifthController),

              ],
            ),
            const SizedBox(height: 55),

            SizedBox(
              width: double.infinity,
              child: MahattatyButton(
                style: MahattatyButtonStyle.primary,
                text: 'Submit', // Button text
                onPressed: () {
                  // Handle the submit action
                },
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.surface), // Optional: Customize text style
                verticalPadding: 17.0, // Customize padding if needed
                horizontalPadding: 20.0, // Customize padding if needed
              ),
            ),

            const SizedBox(height: 30),

            // Resend text
            Text.rich(
              TextSpan(
                text: "Didn't receive the code? ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: customGrey,
                ),
                children: [
                  TextSpan(
                    text: 'Resend',
                    style: TextStyle(color:  Theme.of(context).colorScheme.primary),
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
      ),
    );
  }

  Widget _buildCodeInputField(TextEditingController controller) {
    return SizedBox(
      width: 60,
      child: TextField(

        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:  BorderSide(
              color:  Theme.of(context).colorScheme.onPrimaryContainer, // Border color
            ),
          ),
        ),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

