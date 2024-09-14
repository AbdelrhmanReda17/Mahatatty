import 'package:flutter/material.dart';
import 'package:mahattaty/Utils/open_screens.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Froms/login_form.dart';
import 'package:mahattaty/Widgets/Froms/register_form.dart';
import 'package:mahattaty/Widgets/social_accounts_login.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key = const Key('login_screen')});
  String get loginRouteName => '/authentication/login';
  String get registerRouteName => '/authentication/register';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = widget.key == const Key('login_screen')
        ? const LoginForm()
        : const RegisterForm();

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
            content,
            const SizedBox(height: 20),
            MahattatyButton(
              text: widget.key == const Key('login_screen')
                  ? 'Sign In'
                  : 'Sign Up',
              style: MahattatyButtonStyle.primary,
              onPressed: () {},
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
