import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/settings/Exceptions/settings_exception.dart';
import 'package:mahattaty/features/settings/domain/usecases/change_language_usecase.dart';
import 'package:mahattaty/features/settings/domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/change_mode_usecase.dart';
import '../../domain/usecases/edit_profile_usecase.dart';
import '../../domain/usecases/load_lanuage_usecase.dart';
import '../Providers/change_lang_usecase_provider.dart';
import '../Providers/change_mode_usecase_provider.dart';
import '../Providers/change_password_usecase_provider.dart';
import '../Providers/edit_profile_usecase_provider.dart';
import '../Providers/load_settings_usecase_provider.dart';

class SettingsState {
  final bool isLoading;
  final SettingsException? exception;
  final String language;
  final ThemeMode? mode;
  final bool isSuccessful;

  SettingsState({
    this.isLoading = false,
    this.exception,
    this.language = 'en',
    this.mode = ThemeMode.light,
    this.isSuccessful = false,
  });

  SettingsState copyWith({
    bool? isLoading,
    SettingsException? exception,
    String? language,
    ThemeMode? mode,
    bool? isSuccessful,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      exception: exception ?? this.exception,
      language: language ?? this.language,
      mode: mode ?? this.mode,
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
  final LoadSettingsUseCase loadSettingsUseCase;
  final ChangeLanguageUseCase changeLanguageUseCase;
  final ChangeModeUseCase changeModeUseCase;

  SettingsController(this.editProfileUseCase, this.changePasswordUseCase,
      this.loadSettingsUseCase, this.changeLanguageUseCase,
      this.changeModeUseCase)
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
    } catch (e) {
      state = state.copyWith(
        exception: SettingsException(
          'Error editing profile',
          SettingsErrorAction.editProfile,
          error: SettingsError.unknown,
        ),
        isSuccessful: false,

        isLoading: false,
      );
    }
  }

  void clearState() {
    state = SettingsState();
  }

  Future<void> loadSettings() async {
    try {
      state = state.copyWith(isLoading: true);
      MapEntry<ThemeMode, String> result = await loadSettingsUseCase.call();
      state = state.copyWith(isSuccessful: true,
          isLoading: false,
          language: result.value,
          mode: result.key);
    } catch (e) {
      state = state.copyWith(
        exception: SettingsException(
          'Error loading settings',
          SettingsErrorAction.loadLanguage,
          error: SettingsError.unknown,
        ),
        isSuccessful: false,

        isLoading: false,
      );
    }
  }

  Future<void> changeMode(ThemeMode mode) async {
    state = state.copyWith(isLoading: true);
    try {
      await changeModeUseCase.call(mode);
      state = state.copyWith(isSuccessful: true, isLoading: false, mode: mode);
    } catch (e) {
      state = state.copyWith(
        exception: SettingsException(
          'Error changing mode',
          SettingsErrorAction.changeMode,
          error: SettingsError.unknown,
        ),
        isLoading: false,
      );
    }
  }

  Future<void> changeLanguage(String language) async {
    state = state.copyWith(isLoading: true);
    try {
      await changeLanguageUseCase.call(language);
      state = state.copyWith(
          isSuccessful: true, language: language, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        exception: SettingsException(
          'Error changing language',
          SettingsErrorAction.changeLanguage,
          error: SettingsError.unknown,
        ),
        isSuccessful: false,
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
        isSuccessful: false,

        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        exception: SettingsException(
          'Error changing password',
          SettingsErrorAction.changePassword,
          error: SettingsError.unknown,
        ),
        isSuccessful: false,

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
    ref.read(loadSettingsUseCaseProvider),
    ref.read(changeLanguageUseCaseProvider),
    ref.read(changeModeUseCaseProvider),

  ),
);
