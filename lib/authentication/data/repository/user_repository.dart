import 'package:mahattaty/authentication/domain/repository/user_repository.dart';

import '../../domain/entities/User.dart';
import '../datasource/auth_remote_data_source.dart';

class AuthRepository implements BaseAuthRepository {
  final BaseAuthRemoteDataSource remoteDataSource;

  AuthRepository(this.remoteDataSource);

  @override
  Future<User?> signIn(String email, String password, bool isGoogle) async {
    return remoteDataSource.signIn(email, password, isGoogle);
  }

  @override
  Future<User?> signUp(String username, String email, String password) async {
    return remoteDataSource.signUp(username, email, password);
  }

  @override
  Future<void> signOut() async {
    return remoteDataSource.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    return remoteDataSource.getCurrentUser();
  }

  @override
  Future<bool> forgetPassword(String email) async {
    return remoteDataSource.forgetPassword(email);
  }
}
