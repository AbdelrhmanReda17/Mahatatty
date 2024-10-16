import 'package:flutter/material.dart';

abstract class BaseSettingsRepository {
  Future<void> changeLanguage(String language);
  Future<void> changePassword(String password);
  Future<void> editProfile(String name, String email);
  Future<MapEntry<ThemeMode,String>> loadSettings();
  Future<void> changeMode(ThemeMode mode);
}
