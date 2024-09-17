import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/Providers/States/auth_state.dart';
import 'package:mahattaty/Services/auth_service.dart';
import 'package:mahattaty/Exceptions/auth_exceptions.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(authServiceProvider)),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState()) {
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      state = state.copyWith(user: currentUser, isLoading: false);
    }
    _authService.authStateChanges.listen((user) {
      state = state.copyWith(user: user, isLoading: false);
    });
  }

  void setError(AuthError error) {
    state = state.copyWith(error: error);
  }

  void setLoading(
    bool isLoading,
  ) {
    state = state.copyWith(
        isLoading: isLoading, error: state.error, user: state.user);
  }

  void resetState() {
    state = AuthState();
  }

  void clearErrors() {
    state = state.copyWith(error: null);
  }

  void signOut() {
    _authService.signOut();
    resetState();
  }

  Future<void> submitLogin({
    required String emailOrPhone,
    required String password,
  }) async {
    setLoading(true);
    try {
      final user = await _authService.signIn(emailOrPhone, password);
      if (user != null) {
        state = state.copyWith(user: user, isLoading: false);
      }
    } on AuthException catch (e) {
      setError(AuthError.fromAuthException(e));
      setLoading(false);
    }
  }
  Future<void> submitRegister({
    required String name,
    required String email,
    required String password,
  }) async {
    setLoading(true);
    try {
      final user = await _authService.signUp(name, email, password);
      if (user != null) {
        state = state.copyWith(user: user, isLoading: false);
      }
    } on AuthException catch (e) {
      setError(AuthError.fromAuthException(e));
      setLoading(false);
    }
  }
}
