import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/domain/usecases/signout_usecase.dart';
import 'package:mahattaty/features/settings/domain/usecases/change_language_usecase.dart';

import '../../../../authentication/presentation/providers/signout_proivder.dart';
import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/edit_profile_usecase.dart';
import '../Providers/change_language_usecase_provider.dart';

class SettingsState {
  final bool isLoading;
  final Exception? exception;
  final bool isSuccessful;

  SettingsState({
    this.isLoading = false,
    this.exception,
    this.isSuccessful = false,
  });
}

class SettingsController extends StateNotifier<SettingsState> {
  final ChangeLanguageUseCase changeLanguageUseCase;

  // final ChangePasswordUseCase changePasswordUseCase;
  // final EditProfileUseCase editProfileUseCase;
  final SignOutUseCase signOutUseCase;

  SettingsController(
    this.changeLanguageUseCase,
    // this.changePasswordUseCase,
    // this.editProfileUseCase,
    this.signOutUseCase,
  ) : super(SettingsState());

// void setLoading(bool isLoading) {
//   state = state.copyWith(isLoading: isLoading);
// }
//
// void setException(Exception? exception) {
//   state = state.copyWith(exception: exception);
// }
//
// void setSuccessful(bool isSuccessful) {
//   state = state.copyWith(isSuccessful: isSuccessful);
// }
}

class SettingsControllerProvider {
  static final provider =
      StateNotifierProvider<SettingsController, SettingsState>(
    (ref) => SettingsController(
      ref.read(changeLanguageUseCaseProvider),
      // ref.read(changePasswordUseCaseProvider),
      // ref.read(editProfileUseCaseProvider),
      ref.watch(signOutUseCaseProvider),
    ),
  );
}
