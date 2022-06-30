class UserRegisterParams {
  final String email;
  final String name;
  final String password;
  final DateTime createdOn;
  final DateTime lastLogin;

  UserRegisterParams({
    required this.email,
    required this.name,
    required this.password,
    required this.createdOn,
    required this.lastLogin,
  });
}
