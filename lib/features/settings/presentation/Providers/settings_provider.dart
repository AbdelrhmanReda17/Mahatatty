import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/settings/data/datasource/settings_local_data_resource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasource/settings_remote_data_resource.dart';
import '../../data/repository/settings_repository.dart';
import '../../domain/repository/settings_repository.dart';


final settingsRepositoryProvider = Provider<BaseSettingsRepository>((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  BaseSettingsRemoteDataResource settingsRemoteDataResource =
      SettingsRemoteDataResource(firebaseAuth: firebaseAuth);
  BaseSettingsLocalDataResource settingsLocalDataResource =
      SettingsLocalDataResource();
  return SettingsRepository(remoteDataSource: settingsRemoteDataResource , localDataSource: settingsLocalDataResource);
});
