import '../entities/user.dart';
import '../repository/user_repository.dart';

class SignInUseCase {
  final BaseAuthRepository repository;

  SignInUseCase(this.repository);

  Future<User?> call(String email, String password, bool isGoogle) {
    return repository.signIn(email, password, isGoogle);
  }
}
