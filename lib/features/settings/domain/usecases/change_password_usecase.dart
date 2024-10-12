import '../repository/settings_repository.dart';

class ChangePasswordUseCase {
  final BaseSettingsRepository _userRepository;

  ChangePasswordUseCase(this._userRepository);

  Future<void> call(String password) async {
    return _userRepository.changePassword(password);
  }
}
