import 'package:firebase_auth/firebase_auth.dart';

enum AuthExceptionType {
  wrongEmail,
  wrongPassword,
  userDisabled,
  unknown,
  networkError,
}

class AuthException implements Exception {
  late String message;
  late AuthExceptionType type;

  AuthException({
    required this.message,
    required this.type,
  });

  AuthException.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
      case 'user-not-found':
        type = AuthExceptionType.wrongEmail;
        break;
      case 'user-disabled':
        type = AuthExceptionType.userDisabled;
        break;
      case 'too-many-requests':
      case 'user-token-expired':
      case 'network-request-failed':
        type = AuthExceptionType.networkError;
        break;
      case 'wrong-password':
      case 'INVALID_LOGIN_CREDENTIALS':
      case 'invalid-credential':
        type = AuthExceptionType.wrongPassword;
        break;
      case 'operation-not-allowed':
      default:
        type = AuthExceptionType.unknown;
    }
    message = e.message ?? 'An error occurred';
  }
}
