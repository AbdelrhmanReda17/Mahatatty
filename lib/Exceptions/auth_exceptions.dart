import 'package:firebase_auth/firebase_auth.dart';

enum AuthExceptionType {
  wrongEmail,
  wrongPassword,
  userDisabled,
  unknown,
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
      case 'wrong-password':
        type = AuthExceptionType.wrongPassword;
        message = 'Wrong password provided for that user.';
        break;
      case 'invalid-credential':
        type = AuthExceptionType.wrongEmail;
        message = 'Invalid credential provided for that user.';
        break;
      case 'user-not-found':
        type = AuthExceptionType.wrongEmail;
        message = 'No user found for that email.';
        break;
      case 'user-disabled':
        type = AuthExceptionType.userDisabled;
        message = 'The user account has been disabled by an administrator.';
        break;
      case 'operation-not-allowed':
        type = AuthExceptionType.unknown;
        message =
            'The given sign-in provider is disabled for this Firebase project.';
        break;
      case 'too-many-requests':
        type = AuthExceptionType.unknown;
        message =
            'We have blocked all requests from this device due to unusual activity. Try again later.';
        break;
      case 'email-already-in-use':
        type = AuthExceptionType.wrongEmail;
        message = 'The email address is already in use by another account.';
        break;
      case 'weak-password':
        type = AuthExceptionType.wrongPassword;
        message = 'The password provided is too weak.';
        break;
      default:
        type = AuthExceptionType.unknown;
        message = 'An error occurred, please try again later.';
    }
  }
}
