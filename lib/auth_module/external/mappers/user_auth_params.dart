import 'dart:convert';

import '../../domain/entities/user_auth_params.dart';

class UserAuthParamsMapper {
  Map<String, dynamic> toMap(UserAuthParams object) {
    return {
      'email': object.email,
      'password': object.password,
      'last_login': object.lastLogin.toIso8601String(),
    };
  }

  UserAuthParams fromMap(Map<String, dynamic> map) {
    return UserAuthParams(
      email: map['email'], 
      password: map['password'],
      lastLogin: map['last_login'],
    );
  }

  String toJson(UserAuthParams object) => json.encode(toMap(object));

  UserAuthParams fromJson(String source) => fromMap(json.decode(source));
}