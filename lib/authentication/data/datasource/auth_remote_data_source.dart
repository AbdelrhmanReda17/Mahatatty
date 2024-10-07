import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Exceptions/auth_exception.dart';
import '../models/user_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<UserModel?> signIn(String email, String password, bool isGoogle);

  Future<UserModel?> signUp(String username, String email, String password);

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();

  Future<bool> forgetPassword(String email);
}

class AuthRemoteDataSource implements BaseAuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSource(this.firebaseAuth);

  Future<void> _saveUserToPreferences(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_uuid', user.uuid);
    await prefs.setString('user_email', user.email);
    await prefs.setString('user_name', user.name);
  }

  Future<UserModel?> _getUserFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final uuid = prefs.getString('user_uuid');
    final email = prefs.getString('user_email');
    final name = prefs.getString('user_name');

    if (uuid != null && email != null && name != null) {
      return UserModel(
        uuid: uuid,
        email: email,
        name: name,
      );
    }
    return null;
  }

  @override
  Future<bool> forgetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e, AuthErrorAction.forgetPassword);
    }
  }

  Future<void> _clearUserFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_uuid');
    await prefs.remove('user_email');
    await prefs.remove('user_name');
  }

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(e, AuthErrorAction.signIn);
    } catch (e) {
      log(e.toString());
      throw AuthException(
          FirebaseAuthException(
              message: "An Error occurred while login in with google",
              code: 'unknown'),
          AuthErrorAction.signIn);
    }
    return null;
  }

  @override
  Future<UserModel?> signIn(
      String email, String password, bool isGoogle) async {
    try {
      UserModel? userModel;
      if (isGoogle) {
        final result = await _signInWithGoogle();
        if (result != null) {
          userModel = UserModel(
            uuid: result.uid,
            email: result.email!,
            name: result.displayName ?? "",
          );
        }
      } else {
        final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (result.user != null) {
          userModel = UserModel.fromFirebaseUser(result.user!);
        }
      }
      if (userModel != null) {
        await _saveUserToPreferences(userModel);
      }
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e, AuthErrorAction.signIn);
    }
  }

  @override
  Future<UserModel?> signUp(
      String username, String email, String password) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        await result.user!.updateDisplayName(username);
        await result.user!.reload();
        UserModel userModel = UserModel.fromFirebaseUser(result.user!);
        await _saveUserToPreferences(userModel);
        return userModel;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e, AuthErrorAction.signUp);
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await _clearUserFromPreferences();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      UserModel userModel = UserModel(
        uuid: user.uid,
        email: user.email!,
        name: user.displayName ?? "",
      );
      await _saveUserToPreferences(userModel);
      return userModel;
    }
    return await _getUserFromPreferences();
  }
}
