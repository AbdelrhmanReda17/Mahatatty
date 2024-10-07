import '../repository/user_repository.dart';

class SignOutUseCase {
  final BaseAuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}
