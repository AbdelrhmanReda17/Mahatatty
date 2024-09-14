import 'package:mahattaty/Models/user.dart';

class UserRepositoy {
  static final UserRepositoy _instance = UserRepositoy._internal();
  final List<User> _users = [];

  UserRepositoy._internal();

  factory UserRepositoy() {
    return _instance;
  }

  List<User> get users => _users;

  // Register a new user to the database

  Future<User?> registerUser(User user) async {
    for (var u in _users) {
      if (u.emailOrPhone == user.emailOrPhone) {
        throw Exception('User already exists');
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
          throw Exception('Invalid password');
        }
        return u;
      }
    }
    throw Exception('User not found');
  }
}
