class AuthException implements Exception {
  final String message;
  final bool? emailOrPhoneError;
  final bool? passwordError;

  AuthException({
    required this.message,
    this.emailOrPhoneError,
    this.passwordError,
  });
}
