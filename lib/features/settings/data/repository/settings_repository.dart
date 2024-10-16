import 'package:mahattaty/features/settings/data/datasource/settings_remote_data_resource.dart';
import 'package:mahattaty/features/settings/domain/repository/settings_repository.dart';

import '../datasource/settings_local_data_resource.dart';

class SettingsRepository implements BaseSettingsRepository {
  final BaseSettingsRemoteDataResource remoteDataSource;
  final BaseSettingsLocalDataResource localDataSource;

  SettingsRepository({required this.remoteDataSource , required this.localDataSource});

  @override
  Future<void> changeLanguage(String language) {
    return localDataSource.changeLanguage(language);
  }

  @override
  Future<String> loadSelectedLanguage() {
    return localDataSource.loadSelectedLanguage();
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
