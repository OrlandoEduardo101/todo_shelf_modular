import 'dart:convert';

import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';

class UserEntityMapper {
  Map<String, dynamic> toMap(UserEntity object) {
    return {
      'id': object.id,
      'name': object.name,
      'email': object.email,
      'token': object.token,
      'tokenType': object.tokenType,
      'refreshToken': object.refreshToken,
      'created_on': object.createdOn?.toIso8601String(),
      'last_login': object.lastLogin?.toIso8601String(),
    };
  }

  UserEntity fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      token: map['token'] ?? '',
      tokenType: map['tokenType'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      createdOn: map['created_on'],
      lastLogin: map['last_login'],
    );
  }

  String toJson(UserEntity object) => json.encode(toMap(object));

  UserEntity fromJson(String source) => fromMap(json.decode(source));
}
