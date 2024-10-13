import 'package:flutter/material.dart';

abstract class BaseSettingsRepository {
  Future<void> changeLanguage(String language);

  Future<void> changePassword(String password);

  Future<void> editProfile(String uuid, String name, String email);
}
