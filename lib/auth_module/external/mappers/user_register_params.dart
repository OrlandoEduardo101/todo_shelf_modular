import 'dart:convert';

import '../../domain/entities/user_register_params.dart';

class UserRegisterParamsMapper {
  Map<String, dynamic> toMap(UserRegisterParams object) {
    return {
      'name': object.name,
      'email': object.email,
      'password': object.password,
      'created_on': object.createdOn.toIso8601String(),
      'last_login': object.lastLogin.toIso8601String(),
    };
  }

  UserRegisterParams fromMap(Map<String, dynamic> map) {
    return UserRegisterParams(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      createdOn: DateTime.parse(map['created_on']),
      lastLogin: DateTime.parse(map['last_login']),
    );
  }

  String toJson(UserRegisterParams object) => json.encode(toMap(object));

  UserRegisterParams fromJson(String source) => fromMap(json.decode(source));
}
