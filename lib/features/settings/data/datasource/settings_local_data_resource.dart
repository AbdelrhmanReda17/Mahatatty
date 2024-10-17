import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseSettingsLocalDataResource {
  Future<void> changeLanguage(String language);

  Future<MapEntry<ThemeMode,String>> loadSettings();

  Future<void> changeMode(ThemeMode mode);
}

class SettingsLocalDataResource implements BaseSettingsLocalDataResource {
  SettingsLocalDataResource();

  @override
  Future<void> changeLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', language);
  }

  @override
  Future<void> changeMode(ThemeMode mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_mode', mode.name.toString());
  }

  @override
  Future<MapEntry<ThemeMode,String>> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('selected_language') ?? 'en';
    ThemeMode? mode = prefs.getString('selected_mode') == 'dark' ? ThemeMode.dark : ThemeMode.light;
    return MapEntry(mode, languageCode);
  }

}