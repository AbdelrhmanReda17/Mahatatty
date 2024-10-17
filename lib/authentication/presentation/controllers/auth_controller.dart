import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/Exceptions/auth_exception.dart';
import 'package:mahattaty/authentication/domain/usecases/forget_password_usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/signin_usecase.dart';
import '../../domain/usecases/signout_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../providers/forget_password_provider.dart';
import '../providers/get_current_user_provider.dart';
import '../providers/signin_provider.dart';
import '../providers/signout_proivder.dart';
import '../providers/signup_proivder.dart';

class AuthState {
  final User? user;
  final bool isLoading;
  final AuthException? exception;

  AuthState({this.user, this.isLoading = false, this.exception});
}

class AuthController extends StateNotifier<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;

  AuthController({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.getCurrentUserUseCase,
    required this.forgetPasswordUseCase,
  }) : super(AuthState());

  Future<void> signIn(String email, String password, bool isGoogle) async {
    try {
      state = AuthState(isLoading: true);
      final user = await signInUseCase.call(email, password, isGoogle);
      state = AuthState(user: user, isLoading: false);
    } on AuthException catch (e) {
      state = AuthState(exception: e, isLoading: false);
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    try {
      state = AuthState(isLoading: true);
      final user = await signUpUseCase.call(username, email, password);
      state = AuthState(user: user, isLoading: false);
    } on AuthException catch (e) {
      state = AuthState(exception: e, isLoading: false);
    }
  }

  Future<bool> forgetPassword(String email) async {
    try {
      state = AuthState(isLoading: true);
      bool res = await forgetPasswordUseCase.call(email);
      state = AuthState(isLoading: false);
      return res;
    } on AuthException catch (e) {
      state = AuthState(exception: e, isLoading: false);
      return false;
    }
  }

  void clearException() {
    state = AuthState();
  }

  Future<void> signOut() async {
    await signOutUseCase.call();
    state = AuthState();
  }

  Future<void> getCurrentUser() async {
    try {
      state = AuthState(isLoading: true);
      final user = await getCurrentUserUseCase.call();
      state = AuthState(user: user, isLoading: false);
    } on AuthException catch (e) {
      state = AuthState(exception: e, isLoading: false);
    }
  }

  Future<void> updateCurrentUser() async {
    try{
      state = AuthState(isLoading: true);
      final user = await getCurrentUserUseCase.call();
      state = AuthState(user: user, isLoading: false);
    } on AuthException catch (e) {
      state = AuthState(exception: e, isLoading: false);
    }
  }

  void clearState() {
    state = AuthState();
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(
      signInUseCase: ref.watch(signInUseCaseProvider),
      signUpUseCase: ref.watch(signUpUseCaseProvider),
      signOutUseCase: ref.watch(signOutUseCaseProvider),
      forgetPasswordUseCase: ref.watch(forgetPasswordUseCaseProvider),
      getCurrentUserUseCase: ref.watch(getCurrentUserUseCaseProvider),
    );
  },
);
