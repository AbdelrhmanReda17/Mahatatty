import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/settings/presentation/Providers/settings_provider.dart';

import '../../domain/usecases/load_lanuage_usecase.dart';
final loadLanguageUseCaseProvider = Provider<LoadLanguageUseCase>((ref) {
  final settingsRepository = ref.read(settingsRepositoryProvider);
  return LoadLanguageUseCase(settingsRepository);
});
