import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/settings/domain/usecases/change_password_usecase.dart';
import 'package:mahattaty/features/settings/presentation/Providers/settings_provider.dart';

final changePasswordUseCaseProvider = Provider<ChangePasswordUseCase>((ref) {
  final settingsRepository = ref.read(settingsRepositoryProvider);
  return ChangePasswordUseCase(settingsRepository);
});
