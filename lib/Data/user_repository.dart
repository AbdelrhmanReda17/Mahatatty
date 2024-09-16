import 'package:mahattaty/Models/user.dart';
import 'package:mahattaty/Utils/auth_exception.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  final List<User> _users = [
    User(
      name: 'Example',
      emailOrPhone: 'example@gmail.com',
      password: '123456',
    ),
  ];

  UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  List<User> get users => _users;

  Future<User?> registerUser(User user) async {
    for (var u in _users) {
      if (u.emailOrPhone == user.emailOrPhone) {
        throw AuthException(
            message: 'Email or Phone already exists', emailOrPhoneError: true);
      }
    }
    _users.add(user);
    return user;
  }

  Future<User?> loginUser(
      {required String emailOrPhone, required String password}) async {
    for (var u in _users) {
      if (u.emailOrPhone == emailOrPhone) {
        if (u.password != password) {
          throw AuthException(
              message: 'Invalid password or Email', passwordError: true);
        }
        return u;
      }
    }
    throw AuthException(
        message: 'Invalid Email or Phone', emailOrPhoneError: true);
  }
}
