import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/settings/domain/usecases/change_mode_usecase.dart';
import 'package:mahattaty/features/settings/presentation/Providers/settings_provider.dart';

final changeModeUseCaseProvider = Provider<ChangeModeUseCase>((ref) {
  final settingsRepository = ref.read(settingsRepositoryProvider);
  return ChangeModeUseCase(settingsRepository);
});
