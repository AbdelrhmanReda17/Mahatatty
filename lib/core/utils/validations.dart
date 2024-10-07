extension Validations on String {
  bool _validateEmail(String email) {
    const emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  bool _validatePassword(String password) {
    const passwordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    final regExp = RegExp(passwordPattern);
    return regExp.hasMatch(password);
  }

  bool _validatePhone(String phone) {
    const phonePattern = r'^01[0-2,5]{1}[0-9]{8}$';
    final regExp = RegExp(phonePattern);
    return regExp.hasMatch(phone);
  }

  bool _validateUsername(String username) {
    if (username.isEmpty) return false;
    const usernamePattern = r'^[a-zA-Z0-9]{3,}$';
    final regExp = RegExp(usernamePattern);
    return regExp.hasMatch(username);
  }

  bool _validateConfirmPassword(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  bool get isValidEmail => _validateEmail(this);

  bool get isValidPhone => _validatePhone(this);

  bool get isValidPhoneOrEmail => isValidEmail || isValidPhone;

  bool get isValidPassword => _validatePassword(this);

  bool get isValidUsername => _validateUsername(this);

  bool isValidConfirmPassword(String confirmPassword) =>
      _validateConfirmPassword(this, confirmPassword);
}
