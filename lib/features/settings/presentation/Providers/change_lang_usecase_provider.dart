import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/settings/presentation/Providers/settings_provider.dart';

import '../../domain/usecases/change_language_usecase.dart';

final changeLanguageUseCaseProvider = Provider<ChangeLanguageUseCase>((ref) {
  final settingsRepository = ref.read(settingsRepositoryProvider);
  return ChangeLanguageUseCase(settingsRepository);
});
