import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/Screens/onboarding_screen.dart';
import 'package:mahattaty/Screens/temp_screen.dart';
import 'package:mahattaty/Utils/constant.dart';
import 'package:mahattaty/Utils/open_screens.dart';
import 'package:mahattaty/Widgets/Dialogs/new_password_dialog.dart';

import '../Providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  String get routeName => '/splash';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void navigate() {
    final authState = ref.read(authProvider);
    if (authState.user != null) {
      openScreen(
          context: context,
          routeName: const TempScreen().routeName,
          isReplace: true);
    } else {
      openScreen(
        context: context,
        routeName: OnboardingScreen().routeName,
        isReplace: true,
      );
    }
  }

  void initializeDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData? data) {
      final Uri? deepLink = data?.link;
      if (deepLink != null) {
        String email = deepLink.queryParameters['email'] ?? '';
        if (email.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewPasswordDialog()),
          );
        }
      }
    }).onError((error) {
      log('Dynamic link failed: $error');
    });

    // Check if app is launched with a dynamic link
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink?.link != null) {
      log('App launched with dynamic link: ${initialLink!.link}');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _controller.forward();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 4), () => navigate());
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeDynamicLinks(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(_controller).drive(
              CurveTween(curve: Curves.easeInOut),
            ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                mahattatyLogo,
              ),
              Text("Mahattaty",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
