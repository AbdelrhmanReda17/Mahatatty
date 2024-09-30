import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mahattaty/Exceptions/auth_exceptions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
  Future<User?> signInWithGoogle() async {
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
      throw AuthException.fromFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
        message:
            'An unexpected error occurred during Google Sign-in: ${e.toString()}',
        type: AuthExceptionType.unknown,
      );
    }
    return null;
  }

  Future<bool> sendPasswordResetEmail({required String recipient}) async {
    try {
      await _auth.sendPasswordResetEmail(email: recipient);
      return true;
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
        message:
            'An unexpected error occurred during sending password reset email: ${e.toString()}',
        type: AuthExceptionType.unknown,
      );
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      log('Signing in with Facebook');
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        return userCredential.user;
      } else {
        throw AuthException(
          message: 'Facebook Sign-in failed, please try again',
          type: AuthExceptionType.unknown,
        );
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
        message:
            'An unexpected error occurred during Facebook Sign-in: ${e.toString()}',
        type: AuthExceptionType.unknown,
      );
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw AuthException.fromFirebaseAuthException(e);
    }
  }

  Future<User?> signUp(String name, String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        final updatedUser = _auth.currentUser;
        return updatedUser;
      } else {
        throw AuthException(
            message: 'User creation failed, please try again',
            type: AuthExceptionType.unknown);
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuthException(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
