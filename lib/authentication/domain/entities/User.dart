class User {
  final String uuid;
  final String email;
  final String name;
  final bool isGoogle;
  final bool isEmailVerified;
  final String? photoUrl;

  User({
    required this.uuid,
    required this.email,
    required this.name,
    required this.isGoogle,
    required this.isEmailVerified,
    this.photoUrl,
  });

  @override
  toString() =>
      'User(uuid: $uuid, email: $email, name: $name isGoogle: $isGoogle, isEmailVerified: $isEmailVerified)';
}
