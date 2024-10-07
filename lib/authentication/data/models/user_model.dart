import 'package:mahattaty/authentication/domain/entities/User.dart' as entity;
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends entity.User {
  UserModel({
    required super.uuid,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uuid: json['uuid'],
      email: json['email'],
      name: json['name'],
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uuid: user.uid,
      email: user.email!,
      name: user.displayName!,
    );
  }
}
