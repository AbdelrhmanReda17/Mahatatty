import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/Exceptions/auth_exception.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_button.dart';
import 'package:mahattaty/core/screens/root_screen.dart';
import 'package:mahattaty/onboarding/presentation/controllers/splash_controller.dart';

import '../../../core/generic components/mahattaty_alert.dart';
import '../../../core/utils/open_screens.dart';
import '../components/login_form.dart';
import '../components/register_form.dart';
import '../components/social_account_login.dart';

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({super.key = const Key('login_screen')});

  String get loginRouteName => '/authentication/login';

  String get registerRouteName => '/authentication/register';

  @override
  AuthenticationScreenState createState() => AuthenticationScreenState();
}

class AuthenticationScreenState extends ConsumerState<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin =
        ModalRoute.of(context)!.settings.name == widget.loginRouteName ||
            widget.key == const Key('login_screen');
    Widget content = isLogin ? LoginForm() : RegisterForm();
    ref.listen<AuthState>(
      authControllerProvider,
      (previous, next) {
        if (next.exception != null &&
            next.exception!.code == AuthErrorType.unknownError) {
          mahattatyAlertDialog(
            context,
            message: next.exception!.message,
            type: MahattatyAlertType.error,
          );
        }
        if (next.user != null) {
          OpenScreen.open(
            context: context,
            routeName: const RootScreen().homeRouteName,
            isNamed: true,
            isReplace: true,
          );
        }
      },
    );

    return Scaffold(
      body: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(_controller!).drive(
              CurveTween(curve: Curves.easeInOut),
            ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AppBar(
              titleSpacing: 0,
              toolbarHeight: 80,
              title: RichText(
                text: TextSpan(
                  text: isLogin ? "Login Account\n" : "Create Account\n",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  children: [
                    TextSpan(
                      text: isLogin
                          ? "Please login with registered account"
                          : "Start learning with create your account",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            const SizedBox(height: 8),
            content,
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isLogin
                      ? "Don't have an account?"
                      : "Already have an account?",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: () {
                    OpenScreen.open(
                      context: context,
                      screen: isLogin
                          ? const AuthenticationScreen(
                              key: Key('register_screen'),
                            )
                          : const AuthenticationScreen(
                              key: Key('login_screen'),
                            ),
                      isReplace: true,
                    );
                  },
                  child: Text(
                    isLogin ? 'Sign Up' : 'Sign In',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
            const SocialAccountsLogin(),
            const SizedBox(height: 8),
            isLogin
                ? const SizedBox()
                : RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'by signing up you agree to the ',
                      style: Theme.of(context).textTheme.titleSmall,
                      children: [
                        TextSpan(
                          text: 'Terms & Conditions & Privacy Policy',
                          style: Theme.of(context).textTheme.titleSmall?.apply(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
