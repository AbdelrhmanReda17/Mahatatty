import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/signout_usecase.dart';
import 'auth_provider.dart';

final signOutUseCaseProvider = Provider(
  (ref) {
    final repository = ref.watch(authRepositoryProvider);
    return SignOutUseCase(repository);
  },
);
