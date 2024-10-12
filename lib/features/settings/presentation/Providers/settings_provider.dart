import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/settings_remote_data_resource.dart';
import '../../data/repository/settings_repository.dart';
import '../../domain/repository/settings_repository.dart';
import '../../domain/usecases/edit_profile_usecase.dart';
import '../controllers/settings_controller.dart';

final settingsRepositoryProvider = Provider<BaseSettingsRepository>((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  BaseSettingsRemoteDataResource settingsRemoteDataResource =
  SettingsRemoteDataResource(firebaseAuth: firebaseAuth);
  return SettingsRepository(remoteDataSource: settingsRemoteDataResource);
});

final editProfileUseCaseProvider = Provider<EditProfileUseCase>((ref) {
  final settingsRepository = ref.read(settingsRepositoryProvider);
  return EditProfileUseCase(settingsRepository);
});

final settingsControllerProvider =
StateNotifierProvider<SettingsController, SettingsState>((ref) {
  final editProfileUseCase = ref.read(editProfileUseCaseProvider);
  return SettingsController(editProfileUseCase);
});
