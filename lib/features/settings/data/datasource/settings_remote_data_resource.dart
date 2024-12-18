
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/utils/check_connection.dart';
abstract class BaseSettingsRemoteDataResource {
  Future<void> changePassword(String password);
  Future<void> editProfile(String name, String email);
}

class SettingsRemoteDataResource implements BaseSettingsRemoteDataResource {
  final FirebaseAuth firebaseAuth;

  SettingsRemoteDataResource({required this.firebaseAuth});


  @override
  Future<void> changePassword(String password) async {
    try {
      await CheckConnection.checkInternetConnection();
      await firebaseAuth.currentUser!.updatePassword(password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editProfile(String name, String email) async {
    try {
      await CheckConnection.checkInternetConnection();
      await firebaseAuth.currentUser!.updateEmail(email);
      await firebaseAuth.currentUser!.updateDisplayName(name);
      await firebaseAuth.currentUser!.reload();
    }
    catch (e) {
      rethrow;
    }
  }
}
