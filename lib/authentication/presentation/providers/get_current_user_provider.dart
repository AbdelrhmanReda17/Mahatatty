import 'package:riverpod/riverpod.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import 'auth_provider.dart';

final getCurrentUserUseCaseProvider = Provider(
  (ref) {
    final repository = ref.watch(authRepositoryProvider);
    return GetCurrentUserUseCase(repository);
  },
);
