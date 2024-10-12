import '../../../../authentication/domain/entities/User.dart';
import '../repository/settings_repository.dart';

class EditProfileUseCase {
  final BaseSettingsRepository _userRepository;

  EditProfileUseCase(this._userRepository);

  Future<void> call(String uuid, String username, String email) async {
    return _userRepository.editProfile(
      uuid,
      username,
      email,
    );
  }
}
