import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/features/settings/Exceptions/settings_exception.dart';
import 'package:mahattaty/features/settings/domain/usecases/change_language_usecase.dart';
import 'package:mahattaty/features/settings/domain/usecases/change_password_usecase.dart';
import 'package:mahattaty/features/settings/domain/usecases/load_lanuage_usecase.dart';
import '../../domain/usecases/edit_profile_usecase.dart';
import '../Providers/change_lang_usecase_provider.dart';
import '../Providers/change_password_usecase_provider.dart';
import '../Providers/edit_profile_usecase_provider.dart';
import '../Providers/load_language_usecase_provider.dart';

class SettingsState {
  final bool isLoading;
  final SettingsException? exception;
  final String language;
  final bool isSuccessful;

  SettingsState({
    this.isLoading = false,
    this.exception,
    this.language = 'en',
    this.isSuccessful = false,
  });

  SettingsState copyWith({
    bool? isLoading,
    SettingsException? exception,
    String? language,
    bool? isSuccessful,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      exception: exception ?? this.exception,
      language: language ?? this.language,
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
  final LoadLanguageUseCase loadLanguageUseCase;
  final ChangeLanguageUseCase changeLanguageUseCase;

  SettingsController(this.editProfileUseCase, this.changePasswordUseCase , this.loadLanguageUseCase , this.changeLanguageUseCase)
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

  Future<void> loadLanguage() async {
    state = state.copyWith(isLoading: true);
    try {
      var result = await loadLanguageUseCase.call();
      state = state.copyWith(isSuccessful: true, isLoading: false, language: result);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        exception: SettingsException.fromFirebaseException(
          e,
          SettingsErrorAction.loadLanguage,
        ),
        isLoading: false,
      );
    }
  }

  Future<void> changeLanguage(String language) async {
    state = state.copyWith(isLoading: true);
    try {
      await changeLanguageUseCase.call(language);
      state = state.copyWith(isSuccessful: true, language: language, isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        exception: SettingsException.fromFirebaseException(
          e,
          SettingsErrorAction.changeLanguage,
        ),
        isLoading: false,
      );
    }
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
    ref.read(loadLanguageUseCaseProvider),
    ref.read(changeLanguageUseCaseProvider)
  ),
);
