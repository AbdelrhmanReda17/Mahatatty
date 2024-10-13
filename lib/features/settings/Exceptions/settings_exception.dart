import 'package:firebase_auth/firebase_auth.dart';

enum SettingsError {
  invalidEmail,
  invalidUserName,
  invalidPassword,
  unknown,
}

enum SettingsErrorAction {
  changePassword,
  editProfile,
}

class SettingsException {
  final String message;
  final SettingsErrorAction action;
  final SettingsError? error;

  SettingsException(this.message, this.action, {this.error});

  SettingsException.fromFirebaseException(FirebaseAuthException e, this.action)
      : message = e.message ?? 'An error occurred',
        error = _mapFirebaseAuthExceptionToSettingsErrorType(e);

  static SettingsError _mapFirebaseAuthExceptionToSettingsErrorType(
      FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return SettingsError.invalidEmail;
      case 'email-already-in-use':
        return SettingsError.invalidEmail;
      case 'account-exists-with-different-credential':
        return SettingsError.invalidEmail;
      case 'credential-already-in-use':
        return SettingsError.invalidEmail;
      case 'invalid-email':
        return SettingsError.invalidEmail;
      case 'operation-not-allowed':
        return SettingsError.unknown;
      case 'weak-password':
        return SettingsError.invalidPassword;
      case 'user-not-found':
        return SettingsError.invalidEmail;
      case 'wrong-password':
        return SettingsError.invalidPassword;
      default:
        return SettingsError.unknown;
    }
  }

  @override
  String toString() {
    return 'SettingsException: $message';
  }
}
