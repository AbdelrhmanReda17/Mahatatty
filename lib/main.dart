import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahattaty/Screens/authentication_screen.dart';
import 'package:mahattaty/Screens/onboarding_screen.dart';
import 'package:mahattaty/Screens/splash_screen.dart';
import 'package:mahattaty/Screens/verification_screen.dart';
import 'package:mahattaty/Themes/dark_theme.dart';
import 'package:mahattaty/Themes/light_theme.dart';

void main() {
  runApp(const MyApp());
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
        const SplashScreen().routeName: (context) => const SplashScreen(),
        const OnboardingScreen().routeName: (context) =>
            const OnboardingScreen(),
        const AuthenticationScreen().loginRouteName: (context) =>
            const AuthenticationScreen(
              key: Key('login_screen'),
            ),
        const AuthenticationScreen().registerRouteName: (context) =>
            const AuthenticationScreen(
              key: Key('register_screen'),
            ),
      },
    );
  }
}
