import 'package:riverpod/riverpod.dart';
import '../../domain/usecases/signin_usecase.dart';
import 'auth_provider.dart';

final signInUseCaseProvider = Provider<SignInUseCase>(
  (ref) {
    final repository = ref.watch(authRepositoryProvider);
    return SignInUseCase(repository);
  },
);
