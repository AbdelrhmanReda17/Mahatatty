import 'package:flutter/material.dart';

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
    Widget registerContent = const Center(
      child: Text("Register Screen"),
    );

    Widget loginContent = const Center(
      child: Text("Login Screen"),
    );

    Widget content = widget.key == const Key('login_screen')
        ? loginContent
        : registerContent;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
      ),
      body: content,
    );
  }
}
