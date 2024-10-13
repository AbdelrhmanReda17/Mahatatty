import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/settings/presentation/Providers/settings_provider.dart';
import '../../domain/usecases/edit_profile_usecase.dart';

final editProfileUseCaseProvider = Provider<EditProfileUseCase>((ref) {
  final settingsRepository = ref.read(settingsRepositoryProvider);
  return EditProfileUseCase(settingsRepository);
});