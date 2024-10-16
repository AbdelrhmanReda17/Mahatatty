import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/utils/app_constance.dart';
import '../controllers/splash_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  String get routeName => '/splash';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _controller.forward().whenComplete(
      () async {
        await ref.read(authControllerProvider.notifier).getCurrentUser();
        ref.read(splashControllerProvider.notifier).checkUserStatus(context);
      },
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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
    final TextStyle textStyle = Theme.of(context)
        .textTheme
        .displayLarge!
        .copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
      body: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(_controller).drive(
              CurveTween(curve: Curves.easeInOut),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppConstance.mahattatyLogo),
            Text(AppLocalizations.of(context)!.appName, style: textStyle),
          ],
        ),
      ),
    );
  }
}
