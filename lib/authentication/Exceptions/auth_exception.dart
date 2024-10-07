import 'package:firebase_auth/firebase_auth.dart';

enum AuthErrorType {
  emailError,
  passwordError,
  unknownError,
}

enum AuthErrorAction {
  signIn,
  signUp,
  signOut,
  forgetPassword,
}

class AuthException {
  final AuthErrorType code;
  final AuthErrorAction action;
  final String message;

  AuthException(FirebaseAuthException e, this.action)
      : code = _mapFirebaseAuthExceptionToAuthErrorType(e),
        message = e.message ?? 'Error !';

  static AuthErrorType _mapFirebaseAuthExceptionToAuthErrorType(
      FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return AuthErrorType.emailError;
      case 'email-already-in-use':
        return AuthErrorType.emailError;
      case 'account-exists-with-different-credential':
        return AuthErrorType.emailError;
      case 'credential-already-in-use':
        return AuthErrorType.emailError;
      case 'invalid-email':
        return AuthErrorType.emailError;
      case 'operation-not-allowed':
        return AuthErrorType.unknownError;
      case 'weak-password':
        return AuthErrorType.passwordError;
      case 'user-not-found':
        return AuthErrorType.emailError;
      case 'wrong-password':
        return AuthErrorType.passwordError;
      default:
        return AuthErrorType.unknownError;
    }
  }
}
