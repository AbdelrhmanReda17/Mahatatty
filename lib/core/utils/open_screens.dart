import 'package:flutter/material.dart';

import '../../authentication/presentation/screens/authentication_screen.dart';
import '../../onboarding/presentation/screens/onboarding_screen.dart';

class OpenScreen {
  static void open({
    required BuildContext context,
    Widget? screen,
    String? routeName,
    bool isNamed = false,
    bool isReplace = false,
  }) {
    if (isReplace) {
      if (isNamed) {
        _replaceNamedScreen(context, routeName!);
      } else {
        _replaceScreen(context, screen!);
      }
    } else {
      if (isNamed) {
        _pushNamedScreen(context, routeName!);
      } else {
        _pushScreen(context, screen!);
      }
    }
  }

  static void _pushNamedScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  static void _replaceNamedScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  static void _pushScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static void _replaceScreen(BuildContext context, Widget screen) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static void openScreenWithSmoothAnimation(
      BuildContext context, Widget screen, bool isReplace) {
    if (isReplace) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => screen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    } else {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => screen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    }
  }
}
