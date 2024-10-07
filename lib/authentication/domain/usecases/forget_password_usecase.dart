import '../entities/User.dart';
import '../repository/user_repository.dart';

class ForgetPasswordUseCase {
  final BaseAuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<bool> call(String email) {
    return repository.forgetPassword(email);
  }
}
