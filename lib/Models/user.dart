import 'package:mahattaty/Utils/constant.dart';

class User {
  final String id;
  final String name;
  final String emailOrPhone;
  final String password;
  final String? profileImage;
  final DateTime createdAt;
  final List<String> tickets = [];

  User({
    required this.name,
    required this.emailOrPhone,
    required this.password,
    this.profileImage,
  })  : createdAt = DateTime.now(),
        id = uuid.v4();
}
