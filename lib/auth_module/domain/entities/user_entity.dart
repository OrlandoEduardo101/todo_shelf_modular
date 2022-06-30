class UserEntity {
  final int id;

  final String name;

  final String email;

  final String token;
  final DateTime? createdOn;
  final DateTime? lastLogin;

  UserEntity(
      {this.id = -1,
      this.name = '',
      this.email = '',
      this.token = '',
      this.createdOn,
      this.lastLogin});

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? token,
    DateTime? createdOn,
    DateTime? lastLogin,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      createdOn: createdOn ?? this.createdOn,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}
