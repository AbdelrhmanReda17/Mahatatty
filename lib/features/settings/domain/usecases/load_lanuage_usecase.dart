import '../repository/settings_repository.dart';

class LoadLanguageUseCase {
  final BaseSettingsRepository _userRepository;

  LoadLanguageUseCase(this._userRepository);

  Future<String> call() async {
    return _userRepository.loadSelectedLanguage();
  }
}