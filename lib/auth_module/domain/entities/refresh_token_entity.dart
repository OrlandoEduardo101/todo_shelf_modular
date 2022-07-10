class RefreshTokenEntity {
  final String token;
  final String tokenType;
  final String refreshToken;

  const RefreshTokenEntity({
    this.token = '',
    this.tokenType = '',
    this.refreshToken = 'Bearer',
  });

  RefreshTokenEntity copyWith({
    String? token,
    String? tokenType,
    String? refreshToken,
  }) {
    return RefreshTokenEntity(
      token: token ?? this.token,
      tokenType: tokenType ?? this.tokenType,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
