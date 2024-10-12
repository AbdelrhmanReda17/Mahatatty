import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/settings_remote_data_resource.dart';
import '../../data/repository/settings_repository.dart';
import '../../domain/repository/settings_repository.dart';

final settingsRepositoryProvider = Provider<BaseSettingsRepository>((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  BaseSettingsRemoteDataResource settingsRemoteDataResource =
      SettingsRemoteDataResource(firebaseAuth: firebaseAuth);
  return SettingsRepository(remoteDataSource: settingsRemoteDataResource);
});
