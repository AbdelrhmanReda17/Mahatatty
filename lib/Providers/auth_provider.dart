import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/Data/user_repository.dart';
import 'package:mahattaty/Models/user.dart';
import 'package:mahattaty/Providers/States/auth_state.dart';
import 'package:mahattaty/Utils/auth_exception.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  void setError({String? emailOrPhoneError, String? passwordError}) {
    state = state.copyWith(
        emailOrPhoneError: emailOrPhoneError, passwordError: passwordError);
  }

  void resetState() {
    state = AuthState();
  }

  void clearErrors() {
    setError(emailOrPhoneError: null, passwordError: null);
  }

  void submitLogin(
      {required String emailOrPhone, required String password}) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await UserRepository()
          .loginUser(emailOrPhone: emailOrPhone, password: password);

      if (user != null) {
        log('User Logged in Successfully');
        state = state.copyWith(isSuccess: true, user: user);
      }
    } on AuthException catch (e) {
      setError(
        emailOrPhoneError: e.emailOrPhoneError == true ? e.message : null,
        passwordError: e.passwordError == true ? e.message : null,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void submitRegister({
    required String name,
    required String emailOrPhone,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      User? user = await UserRepository().registerUser(
        User(
          name: name,
          emailOrPhone: emailOrPhone,
          password: password,
        ),
      );
      if (user != null) {
        state = state.copyWith(isSuccess: true, user: user);
      }
    } on AuthException catch (e) {
      setError(
        emailOrPhoneError: e.emailOrPhoneError == true ? e.message : null,
        passwordError: e.passwordError == true ? e.message : null,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
