import '../repository/settings_repository.dart';

class ChangeLanguageUseCase {
  final BaseSettingsRepository _userRepository;

  ChangeLanguageUseCase(this._userRepository);

  Future<void> call(String lang) async {
    return _userRepository.changeLanguage(lang);
  }
}
