import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/data/repository/user_repository.dart';
import 'package:mahattaty/authentication/domain/repository/user_repository.dart';
import '../../data/datasource/auth_remote_data_source.dart';

final authRepositoryProvider = Provider<BaseAuthRepository>(
  (ref) {
    final firebaseAuth = FirebaseAuth.instance;
    final authDataSource = AuthRemoteDataSource(firebaseAuth);
    return AuthRepository(authDataSource);
  },
);
