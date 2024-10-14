import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/features/settings/Exceptions/settings_exception.dart';
import 'package:mahattaty/features/settings/domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/edit_profile_usecase.dart';
import '../Providers/change_password_usecase_provider.dart';
import '../Providers/edit_profile_usecase_provider.dart';

class SettingsState {
  final bool isLoading;
  final SettingsException? exception;
  final bool isSuccessful;

  SettingsState({
    this.isLoading = false,
    this.exception,
    this.isSuccessful = false,
  });

  SettingsState copyWith({
    bool? isLoading,
    SettingsException? exception,
    bool? isSuccessful,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      exception: exception ?? this.exception,
      isSuccessful: isSuccessful ?? this.isSuccessful,
    );
  }

  String? getError(SettingsErrorAction action, SettingsError errorType) {
    return exception?.action == action && exception?.error == errorType
        ? exception?.message
        : null;
  }
}

class SettingsController extends StateNotifier<SettingsState> {
  final EditProfileUseCase editProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  SettingsController(this.editProfileUseCase, this.changePasswordUseCase)
      : super(SettingsState());

  Future<void> editProfile(
      {required String name, required String email}) async {
    state = state.copyWith(isLoading: true);
    try {
      await editProfileUseCase.call(name, email);
      state = state.copyWith(isSuccessful: true, isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        exception: SettingsException.fromFirebaseException(
          e,
          SettingsErrorAction.editProfile,
        ),
        isLoading: false,
      );
    }
  }

  void clearState() {
    state = SettingsState();
  }

  Future<void> changePassword(String password) async {
    state = state.copyWith(isLoading: true);
    try {
      await changePasswordUseCase.call(password);
      state = state.copyWith(isSuccessful: true, isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        exception: SettingsException.fromFirebaseException(
          e,
          SettingsErrorAction.changePassword,
        ),
        isLoading: false,
      );
    }
  }
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>(
  (ref) => SettingsController(
    ref.read(editProfileUseCaseProvider),
    ref.read(changePasswordUseCaseProvider),
  ),
);
