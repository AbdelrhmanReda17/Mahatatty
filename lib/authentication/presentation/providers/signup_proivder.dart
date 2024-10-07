import 'package:riverpod/riverpod.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'auth_provider.dart';

final signUpUseCaseProvider = Provider(
  (ref) {
    final repository = ref.watch(authRepositoryProvider);
    return SignUpUseCase(repository);
  },
);
