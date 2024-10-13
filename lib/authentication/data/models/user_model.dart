import 'package:mahattaty/authentication/domain/entities/user.dart' as entity;
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends entity.User {
  UserModel({
    required super.uuid,
    required super.email,
    required super.name,
  });

  // Create a factory constructor to create UserModel from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uuid: json['uuid'],
      email: json['email'],
      name: json['name'],
    );
  }

  // Create a factory constructor to create UserModel from a Firebase User
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uuid: user.uid,
      email: user.email ?? '', // Handle null email case safely
      name: user.displayName ?? '', // Handle null display name case safely
    );
  }

  // Create a method to convert UserModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'email': email,
      'name': name,
    };
  }
}
