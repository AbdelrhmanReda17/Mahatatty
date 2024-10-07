class User {
  final String uuid;
  final String email;
  final String name;

  User({
    required this.uuid,
    required this.email,
    required this.name,
  });

  @override
  toString() => 'User(uuid: $uuid, email: $email, name: $name)';
}
