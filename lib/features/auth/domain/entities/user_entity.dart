class User {
  final String id;
  final String email;
  final String password;
  final bool verify;
  final String token;

  const User({
    required this.id,
    required this.email,
    required this.password,
    required this.verify,
    required this.token,
  });

  static const empty = User(id: "", email: "", password: "", verify: false, token: "");
}
