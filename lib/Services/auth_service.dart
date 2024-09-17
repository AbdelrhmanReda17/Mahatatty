import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahattaty/Exceptions/auth_exceptions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<User?> signIn(String email, String password) async {
    log(email + password);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      log(userCredential.user!.email!);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
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
            message: 'User creation failed, no user returned.',
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
