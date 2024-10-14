import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/presentation/screens/authentication_screen.dart';
import 'package:mahattaty/core/screens/root_screen.dart';
import 'package:mahattaty/features/news/presentation/screens/news_screen.dart';
import 'package:mahattaty/onboarding/presentation/screens/splash_screen.dart';
import 'package:mahattaty/themes/dark_theme.dart';
import 'package:mahattaty/themes/light_theme.dart';
import 'features/train_booking/domain/entities/ticket.dart';
import 'features/train_booking/presentation/screens/train_search_screen.dart';
import 'firebase_options.dart';
import 'dart:developer';

import 'onboarding/presentation/screens/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => log('Firebase initialized'));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: const SplashScreen().routeName,
      routes: {
        const RootScreen().homeRouteName: (context) => const RootScreen(
              key: Key('home_screen'),
            ),
        const RootScreen().exploreRouteName: (context) => const RootScreen(
              key: Key('explore_screen'),
            ),
        const RootScreen().profileRouteName: (context) => const RootScreen(
              key: Key('profile_screen'),
            ),
        const RootScreen().myTicketRouteName: (context) => const RootScreen(
              key: Key('my_ticket_screen'),
            ),
        const SplashScreen().routeName: (context) => const SplashScreen(),
        const OnboardingScreen().routeName: (context) =>
            const OnboardingScreen(),
        const AuthenticationScreen().loginRouteName: (context) =>
            const AuthenticationScreen(key: Key('login_screen')),
        const AuthenticationScreen().registerRouteName: (context) =>
            const AuthenticationScreen(key: Key('register_screen')),

        // '/settings': (context) => const SettingsScreen(),
        // '/editProfile': (context) => const EditProfileScreen(),
        // // '/changePassword': (context) => const ChangePasswordScreen(),
        // '/legal-and-policies': (context) => const LegalAndPoliciesScreen()
      },
    );
  }
}
