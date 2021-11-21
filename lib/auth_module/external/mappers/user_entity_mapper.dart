import 'dart:convert';

import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';

class UserEntityMapper {
  Map<String, dynamic> toMap(UserEntity object) {
    return {
      'id': object.id,
      'name': object.name,
      'email': object.email,
      'token': object.token,
    };
  }

  UserEntity fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      token: map['token'],
    );
  }

  String toJson(UserEntity object) => json.encode(toMap(object));

  UserEntity fromJson(String source) => fromMap(json.decode(source));
}