import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/domain/entities/User.dart';
import 'package:mahattaty/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:mahattaty/core/screens/root_screen.dart';
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
      ref.watch(getCurrentUserUseCaseProvider),
      ref.watch(checkOnboardingStatusProvider),
      ref.watch(setOnboardingSeenProvider),
    );
  },
);

class SplashController extends StateNotifier<AsyncValue<User?>> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CheckOnboardingStatusUseCase checkOnboardingStatusUseCase;
  final SetOnboardingSeenUseCase setOnboardingSeenUseCase;

  SplashController(this.getCurrentUserUseCase,
      this.checkOnboardingStatusUseCase, this.setOnboardingSeenUseCase)
      : super(const AsyncValue.loading());

  Future<void> checkUserStatus(BuildContext context) async {
    try {
      final User? user = await getCurrentUserUseCase.call();
      if (user != null) {
        log('User is logged in: ${user.toString()}');
        OpenScreen.open(
          context: context,
          screen: const RootScreen(
            key: Key('home_screen'),
          ), // HOME SCREEN !
          isReplace: true,
        );
      } else {
        // Check onboarding status
        final hasSeenOnboarding = await checkOnboardingStatusUseCase.execute();
        if (!hasSeenOnboarding) {
          await setOnboardingSeenUseCase.execute();
          // If onboarding is seen for the first time, navigate to onboarding
          OpenScreen.open(
            context: context,
            screen: const OnboardingScreen(),
            isReplace: true,
          );
        } else {
          // If not the first time, navigate to login
          OpenScreen.open(
            context: context,
            screen: const AuthenticationScreen(),
            isReplace: true,
          );
        }
      }
    } catch (e) {
      log('Error checking user: $e');
      OpenScreen.open(
        context: context,
        screen: const AuthenticationScreen(),
        isReplace: true,
      );
    }
  }
}
