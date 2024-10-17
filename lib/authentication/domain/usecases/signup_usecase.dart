import '../entities/user.dart';
import '../repository/user_repository.dart';

class SignUpUseCase {
  final BaseAuthRepository repository;

  SignUpUseCase(this.repository);

  Future<User?> call(String username, String email, String password) {
    return repository.signUp(username, email, password);
  }
}
