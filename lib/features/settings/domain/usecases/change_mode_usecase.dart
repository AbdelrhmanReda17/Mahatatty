import 'package:flutter/material.dart';

import '../repository/settings_repository.dart';

class ChangeModeUseCase {
  final BaseSettingsRepository _userRepository;

  ChangeModeUseCase(this._userRepository);

  Future<void> call(ThemeMode mode) async {
    return _userRepository.changeMode(mode);
  }
}