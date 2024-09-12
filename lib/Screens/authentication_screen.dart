import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Utils/open_screens.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';
import 'package:mahattaty/Widgets/social_accounts_login.dart';

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
    List<Widget> registerContent = [
      MahattatyTextFormField(
        labelText: 'Full Name',
        controller: TextEditingController(),
        iconData: FontAwesomeIcons.user,
      ),
      const SizedBox(height: 20),
      MahattatyTextFormField(
        labelText: 'Email',
        controller: TextEditingController(),
        iconData: FontAwesomeIcons.envelope,
      ),
      const SizedBox(height: 20),
      MahattatyTextFormField(
        labelText: 'Password',
        controller: TextEditingController(),
        isPassword: true,
        iconData: FontAwesomeIcons.lock,
      ),
      const SizedBox(height: 20),
      MahattatyTextFormField(
        labelText: 'Confirm Password',
        controller: TextEditingController(),
        isPassword: true,
        iconData: FontAwesomeIcons.lock,
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
      const Center(
        child: Text("Login Screen"),
      )
    ];

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
                openScreen(
                  context: context,
                  routeName: widget.key == const Key('login_screen')
                      ? widget.registerRouteName
                      : widget.loginRouteName,
                  isReplace: true,
                );
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
