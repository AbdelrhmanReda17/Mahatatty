import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class BaseSettingsRemoteDataResource {
  Future<void> changeLanguage(String language);

  Future<void> changePassword(String password);

  Future<void> editProfile(String name, String email);
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
    try {
      return firebaseAuth.currentUser!.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editProfile(String name, String email) async {
    try {
      await firebaseAuth.currentUser!.updateEmail(email);
      await firebaseAuth.currentUser!.updateDisplayName(name);
      await firebaseAuth.currentUser!.reload();
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }
}
