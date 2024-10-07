import '../entities/User.dart';
import '../repository/user_repository.dart';

class GetCurrentUserUseCase {
  final BaseAuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<User?> call() {
    return repository.getCurrentUser();
  }
}
