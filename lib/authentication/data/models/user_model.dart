import 'package:mahattaty/authentication/domain/entities/User.dart' as entity;
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends entity.User {
  UserModel({
    required super.uuid,
    required super.email,
    required super.name,
    required super.isGoogle,
    required super.isEmailVerified,
    super.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uuid: json['uuid'],
      email: json['email'],
      name: json['name'],
      isGoogle: json['isGoogle'],
      isEmailVerified: json['isEmailVerified'],
      photoUrl: json['photoUrl'],
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uuid: user.uid,
      email: user.email!,
      name: user.displayName!,
      isGoogle: user.providerData[0].providerId == 'google.com',
      isEmailVerified: user.emailVerified,
      photoUrl: user.photoURL,
    );
  }
}
