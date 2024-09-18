import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahattaty/Exceptions/auth_exceptions.dart';

enum AuthErrorType {
  unknown,
  emailOrPhone,
  password,
  networkError,
}

class AuthError {
  String? message;
  AuthErrorType? type;

  AuthError({this.message, this.type});

  AuthError copyWith({bool? isError, String? message}) {
    return AuthError(
      message: message ?? this.message,
    );
  }

  AuthError.fromAuthException(AuthException exception) {
    switch (exception.type) {
      case AuthExceptionType.wrongEmail:
        type = AuthErrorType.emailOrPhone;
        break;
      case AuthExceptionType.wrongPassword:
        type = AuthErrorType.password;
        break;
      case AuthExceptionType.networkError:
        type = AuthErrorType.networkError;
        break;
      default:
        type = AuthErrorType.unknown;
    }
    message = exception.message;
  }

  @override
  String toString() {
    return 'AuthError{message: $message}';
  }
}

class AuthState {
  final bool isLoading;
  final User? user;
  final AuthError? error;

  AuthState({
    this.isLoading = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    User? user,
    AuthError? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
  
  @override
  String toString() {
    return 'AuthState{isLoading: $isLoading, user: $user , error: $error}';
  }
}
