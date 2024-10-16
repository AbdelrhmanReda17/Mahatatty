import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/domain/entities/User.dart';
import 'package:mahattaty/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:mahattaty/core/screens/root_screen.dart';
import '../../../authentication/presentation/controllers/auth_controller.dart';
import '../../../authentication/presentation/providers/get_current_user_provider.dart';
import '../../../authentication/presentation/screens/authentication_screen.dart';
import '../../../core/utils/open_screens.dart';
import '../../domain/usecases/check_onboarding_status_usecase.dart';
import '../../domain/usecases/set_onboarding_seen_usecase.dart';
import '../providers/check_onboaring_status_provider.dart';
import '../providers/set_onboarding_seen_provider.dart';
import '../screens/onboarding_screen.dart';

final splashControllerProvider =
    StateNotifierProvider<SplashController, AsyncValue<User?>>(
  (ref) {
    return SplashController(
      ref.watch(authControllerProvider).user,
      ref.watch(checkOnboardingStatusProvider),
      ref.watch(setOnboardingSeenProvider),
    );
  },
);

class SplashController extends StateNotifier<AsyncValue<User?>> {
  final CheckOnboardingStatusUseCase checkOnboardingStatusUseCase;
  final SetOnboardingSeenUseCase setOnboardingSeenUseCase;
  final User? user;

  SplashController(this.user, this.checkOnboardingStatusUseCase,
      this.setOnboardingSeenUseCase)
      : super(const AsyncValue.loading());

  Future<void> checkUserStatus(BuildContext context) async {
    try {
      if (user != null) {
        OpenScreen.open(
          context: context,
          routeName: const RootScreen().homeRouteName,
          isNamed: true,
          isReplace: true,
        );
        } else {
        final hasSeenOnboarding = await checkOnboardingStatusUseCase.execute();
        if (!hasSeenOnboarding) {
          await setOnboardingSeenUseCase.execute();
          OpenScreen.open(
            context: context,
            screen: const OnboardingScreen(),
            isReplace: true,
          );
        } else {
          OpenScreen.open(
            context: context,
            screen: const AuthenticationScreen(),
            isReplace: true,
          );
        }
      }
    } catch (e) {
      OpenScreen.open(
        context: context,
        screen: const AuthenticationScreen(),
        isReplace: true,
      );
    }
  }
}
