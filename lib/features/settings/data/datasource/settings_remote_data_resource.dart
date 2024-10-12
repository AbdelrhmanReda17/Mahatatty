import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class BaseSettingsRemoteDataResource {
  Future<void> changeLanguage(String language);

  Future<void> changePassword(String password);

  Future<void> editProfile(String uuid, String name, String email);
}

class SettingsRemoteDataResource implements BaseSettingsRemoteDataResource {
  final FirebaseAuth firebaseAuth;

  SettingsRemoteDataResource({required this.firebaseAuth});

  @override
  Future<void> changeLanguage(String language) {
    throw UnimplementedError();
  }

  @override
  Future<void> changePassword(String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> editProfile(String uuid, String name, String email) {
    throw UnimplementedError();
  }
}
