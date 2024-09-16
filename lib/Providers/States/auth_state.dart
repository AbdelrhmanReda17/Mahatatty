import 'package:mahattaty/Models/user.dart';

class AuthState {
  final bool isLoading;
  final bool isSuccess;
  final User? user;
  final String? emailOrPhoneError;
  final String? passwordError;

  AuthState({
    this.isLoading = false,
    this.isSuccess = false,
    this.user,
    this.emailOrPhoneError,
    this.passwordError,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isSuccess,
    User? user,
    String? emailOrPhoneError,
    String? passwordError,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      user: user ?? this.user,
      emailOrPhoneError: emailOrPhoneError,
      passwordError: passwordError,
    );
  }

  @override
  String toString() {
    return 'AuthState{isLoading: $isLoading, isSuccess: $isSuccess, user: $user, emailOrPhoneError: $emailOrPhoneError, passwordError: $passwordError }';
  }
}
