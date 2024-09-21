import 'package:flutter/material.dart';
import 'package:mahattaty/Utils/open_screens.dart';
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

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller!.forward();
    });
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
            const SizedBox(height: 20),
            content,
            const SizedBox(height: 10),
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
                    Navigator.of(context).pop();
                    openScreen(
                      context: context,
                      routeName: isLogin
                          ? widget.registerRouteName
                          : widget.loginRouteName,
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
            const SizedBox(height: 20),
            isLogin
                ? const SizedBox()
                : RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'by signing up you agree to the ',
                      style: Theme.of(context).textTheme.titleSmall,
                      children: [
                        TextSpan(
                          text: 'Terms & Conditions & Privacy\nPolicy',
                          style: Theme.of(context).textTheme.titleSmall?.apply(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        TextSpan(
                          text: ' set out by Mahattaty',
                          style: Theme.of(context).textTheme.titleSmall,
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
