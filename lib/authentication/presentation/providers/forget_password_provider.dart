import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/domain/usecases/forget_password_usecase.dart';

import 'auth_provider.dart';

final forgetPasswordUseCaseProvider = Provider(
  (ref) {
    final repository = ref.watch(authRepositoryProvider);
    return ForgetPasswordUseCase(repository);
  },
);
