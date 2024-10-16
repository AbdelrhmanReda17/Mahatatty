import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/presentation/screens/authentication_screen.dart';
import 'package:mahattaty/core/screens/root_screen.dart';
import 'package:mahattaty/onboarding/presentation/screens/splash_screen.dart';
import 'package:mahattaty/themes/dark_theme.dart';
import 'package:mahattaty/themes/light_theme.dart';
import 'features/settings/presentation/controllers/settings_controller.dart';
import 'firebase_options.dart';
import 'dart:developer';
import 'onboarding/presentation/screens/onboarding_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    log('Firebase initialized');
  } catch (e) {
    log('Error initializing Firebase: $e');
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(settingsControllerProvider.notifier).loadLanguage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);

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

    log('Current language: ${settings.language}');

    return MaterialApp(
      title: 'Mahattaty',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all,
      locale: Locale(settings.language),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute:const SplashScreen().routeName,
      routes: {
        const RootScreen().homeRouteName: (context) => const RootScreen(key: Key('home_screen')),
        const RootScreen().exploreRouteName: (context) => const RootScreen(key: Key('explore_screen')),
        const RootScreen().profileRouteName: (context) => const RootScreen(key: Key('profile_screen')),
        const RootScreen().myTicketRouteName: (context) => const RootScreen(key: Key('my_ticket_screen')),
        const SplashScreen().routeName: (context) => const SplashScreen(),
        const OnboardingScreen().routeName: (context) => const OnboardingScreen(),
        const AuthenticationScreen().loginRouteName: (context) => const AuthenticationScreen(key: Key('login_screen')),
        const AuthenticationScreen().registerRouteName: (context) => const AuthenticationScreen(key: Key('register_screen')),
      },
    );
  }
}
