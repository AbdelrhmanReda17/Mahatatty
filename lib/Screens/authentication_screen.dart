import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Utils/open_screens.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';
import 'package:mahattaty/Widgets/social_accounts_login.dart';

import '../Themes/light_theme.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key = const Key('login_screen')});
  String get loginRouteName => '/authentication/login';
  String get registerRouteName => '/authentication/register';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {

    //show create new password dialog
    void _showCreateNewPasswordDialog(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 6.0, // Thickness of the line
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(5.0), // Radius for the left end
                        right: Radius.circular(5.0), // Radius for the right end
                      ),
                    ),
                    width: 70,
                  ),
                ),
                const SizedBox(height: 40),

                Text(
                  'Create new password ',
                  style: Theme.of(context)
                      .textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter your new password and confirm it',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: customGrey,
                  ),
                ),

                const SizedBox(height: 35),
                MahattatyTextFormField(
                  labelText: 'Password',
                  controller: TextEditingController(),
                  isPassword: true,
                  iconData: FontAwesomeIcons.lock,
                  hintText: 'Create your password',

                ),
                const SizedBox(height: 20),
                MahattatyTextFormField(
                  labelText: 'Confirm Password',
                  controller: TextEditingController(),
                  isPassword: true,
                  iconData: FontAwesomeIcons.lock,
                  hintText: 'Enter your password again',

                ),
                const SizedBox(height: 45),
                MahattatyButton(
                  text: 'Change Password',
                  style: MahattatyButtonStyle.primary,
                  onPressed: () {
                   //Verify password
                  },
                  height: 50,
                ),
              ],
            ),
          );
        },
      );
    }

    // Show forgot password dialog
    void _showForgotPasswordDialog(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 6.0, // Thickness of the line
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(5.0), // Radius for the left end
                        right: Radius.circular(5.0), // Radius for the right end
                      ),
                    ),
                    width: 70,
                  ),
                ),
                const SizedBox(height: 40),

                Text(
                  'Forgot Password',
                  style: Theme.of(context)
                      .textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter your email or phone number',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: customGrey,
                  ),
                ),

                const SizedBox(height: 20),
                MahattatyTextFormField(
                  labelText: 'Email or Phone Number',
                  controller: TextEditingController(),
                  iconData: FontAwesomeIcons.envelope,
                  hintText: 'Enter your email or phone number',
                ),
                const SizedBox(height: 45),
                MahattatyButton(
                  text: 'Send Code',
                  style: MahattatyButtonStyle.primary,
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the current bottom sheet
                    _showCreateNewPasswordDialog(context); // Show new password dialog
                  },
                  height: 50,
                ),
              ],
            ),
          );
        },
      );
    }


    List<Widget> registerContent = [
      MahattatyTextFormField(
        labelText: 'Full Name',
        controller: TextEditingController(),
        iconData: FontAwesomeIcons.user,
        hintText: 'Enter your Full Name',

      ),
      const SizedBox(height: 20),
      MahattatyTextFormField(
        labelText: 'Email or Phone Number',
        controller: TextEditingController(),
        iconData: FontAwesomeIcons.envelope,
        hintText: 'Enter your email or phone number',

      ),
      const SizedBox(height: 20),
      MahattatyTextFormField(
        labelText: 'Password',
        controller: TextEditingController(),
        isPassword: true,
        iconData: FontAwesomeIcons.lock,
        hintText: 'Create your password',

      ),
      const SizedBox(height: 20),
      MahattatyTextFormField(
        labelText: 'Confirm Password',
        controller: TextEditingController(),
        isPassword: true,
        iconData: FontAwesomeIcons.lock,
        hintText: 'Enter your password again',

      ),
      const SizedBox(height: 20),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: true,
            onChanged: (bool? value) {},
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'I accept the ',
                    style: Theme.of(context).textTheme.titleSmall,
                    children: [
                      TextSpan(
                          text: 'Terms & Conditions & Privacy\nPolicy',
                          style: Theme.of(context).textTheme.titleSmall?.apply(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          children: [
                            TextSpan(
                              text: ' set out by Mahattaty',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ]),
                    ]),
              ],
            ),
          ),
        ],
      ),
    ];

    List<Widget> loginContent = [
        MahattatyTextFormField(
          labelText: 'Email or Phone Number',
          controller: TextEditingController(),
          iconData: FontAwesomeIcons.envelope,
          hintText: 'Enter your email or phone number',
        ),
      const SizedBox(height: 20),
      MahattatyTextFormField(
        labelText: 'Password',
        controller: TextEditingController(),
        isPassword: true,
        iconData: FontAwesomeIcons.lock,
        hintText: 'Create your password',
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          const Spacer(), // Pushes the text to the right
          GestureDetector(
            onTap: () => _showForgotPasswordDialog(context),  // Trigger the dialog
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16.5,
              ),
            ),
          ),
        ],
      ),];

    List content = widget.key == const Key('login_screen')
        ? loginContent
        : registerContent;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: RichText(
          text: TextSpan(
            text: widget.key == const Key('login_screen')
                ? "Login Account\n"
                : "Create Account\n",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            children: [
              TextSpan(
                text: widget.key == const Key('login_screen')
                    ? "Please login with registered account"
                    : "Start learning with create your account",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            ...content,
            const SizedBox(height: 20),
            MahattatyButton(
              text: widget.key == const Key('login_screen')
                  ? 'Sign In'
                  : 'Sign Up',
              style: MahattatyButtonStyle.primary,
              onPressed: () {

              },
              height: 50,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.key == const Key('login_screen')
                      ? "Don't have an account?"
                      : "Already have an account?",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: () {
                    openScreen(
                      context: context,
                      routeName: widget.key == const Key('login_screen')
                          ? widget.registerRouteName
                          : widget.loginRouteName,
                      isReplace: true,
                    );
                  },
                  child: Text(
                    widget.key == const Key('login_screen')
                        ? 'Sign Up'
                        : 'Sign In',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
            const SocialAccountsLogin(),
          ],
        ),
      ),
    );
  }
}
