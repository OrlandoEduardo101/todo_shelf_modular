class UserAuthParams {
  final String email;
  final DateTime lastLogin;
  final String password;

  UserAuthParams({
    required this.email,
    required this.password,
    required this.lastLogin,
  });
}
