import '../entities/User.dart';

abstract class BaseAuthRepository {
  Future<User?> signIn(String email, String password, bool isGoogle);

  Future<User?> signUp(String username, String email, String password);

  Future<void> signOut();

  Future<User?> getCurrentUser();

  Future<bool> forgetPassword(String email);
}
