import 'package:flutter/material.dart';

import '../repository/settings_repository.dart';

class LoadSettingsUseCase {
  final BaseSettingsRepository _userRepository;

  LoadSettingsUseCase(this._userRepository);

  Future<MapEntry<ThemeMode,String>> call() async {
    return _userRepository.loadSettings();
  }
}