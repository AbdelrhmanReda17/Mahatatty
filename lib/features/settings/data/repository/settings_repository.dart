import 'package:mahattaty/features/settings/data/datasource/settings_remote_data_resource.dart';
import 'package:mahattaty/features/settings/domain/repository/settings_repository.dart';

class SettingsRepository implements BaseSettingsRepository {
  final BaseSettingsRemoteDataResource remoteDataSource;

  SettingsRepository({required this.remoteDataSource});

  @override
  Future<void> changeLanguage(String language) {
    return remoteDataSource.changeLanguage(language);
  }

  @override
  Future<void> changePassword(String password) {
    return remoteDataSource.changePassword(password);
  }

  @override
  Future<void> editProfile(String name, String email) {
    return remoteDataSource.editProfile(name, email);
  }
}
