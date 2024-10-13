import '../../../../authentication/data/models/user_model.dart';
import '../repository/settings_repository.dart';

class EditProfileUseCase {
  final BaseSettingsRepository _repository;

  EditProfileUseCase(this._repository);

  Future<void> execute(UserModel userModel) async {
    return _repository.editProfile(userModel.uuid, userModel.name, userModel.email);
  }
}
