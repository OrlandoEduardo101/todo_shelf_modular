import 'dart:convert';

import '../../domain/entities/refresh_token_entity.dart';


class RefreshTokenEntityMapper {
  Map<String, dynamic> toMap(RefreshTokenEntity object) {
    return {
      'token': object.token,
      'tokenType': object.tokenType,
      'refreshToken': object.refreshToken,
    };
  }

  RefreshTokenEntity fromMap(Map<String, dynamic> map) {
    return RefreshTokenEntity(
      token: map['token'] ?? '',
      tokenType: map['tokenType'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }

  String toJson(RefreshTokenEntity object) => json.encode(toMap(object));

  RefreshTokenEntity fromJson(String source) => fromMap(json.decode(source));
}
