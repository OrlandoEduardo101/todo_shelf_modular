class UserEntity {
  final int id;
  final String name;
  final String email;
  final String token;
  final String tokenType;
  final String refreshToken;
  final DateTime? createdOn;
  final DateTime? lastLogin;

  UserEntity({
    this.id = -1,
    this.name = '',
    this.email = '',
    this.token = '',
    this.refreshToken = '',
    this.tokenType = 'Bearer',
    this.createdOn,
    this.lastLogin,
  });

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? token,
    String? tokenType,
    String? refreshToken,
    DateTime? createdOn,
    DateTime? lastLogin,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      tokenType: tokenType ?? this.tokenType,
      refreshToken: refreshToken ?? this.refreshToken,
      createdOn: createdOn ?? this.createdOn,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}
