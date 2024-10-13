import '../repository/settings_repository.dart';

class EditProfileUseCase {
  final BaseSettingsRepository _repository;

  EditProfileUseCase(this._repository);

  Future<void> call(String name, String email) async {
    return _repository.editProfile(name, email);
  }
}
