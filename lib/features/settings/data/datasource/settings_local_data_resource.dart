import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseSettingsLocalDataResource {
  Future<void> changeLanguage(String language);

  Future<String> loadSelectedLanguage();
}

class SettingsLocalDataResource implements BaseSettingsLocalDataResource {
  SettingsLocalDataResource();

  @override
  Future<void> changeLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', language);
  }

  @override
  Future<String> loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('selected_language') ?? 'en';
    return languageCode;
  }

}