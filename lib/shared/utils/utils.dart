import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';

class Utils {
  static const String jwtKey = "<your_private_key>";

  const Utils();

  static String generateJWT(UserEntity user) {
    final claimSet = JwtClaim(
      issuer: "http://localhost:8888",
      subject: user.id.toString(),
      otherClaims: <String, dynamic>{},
      maxAge: const Duration(days: 1),
    );
    final token = "Bearer ${issueJwtHS256(claimSet, jwtKey)}";
    return token;
  }

  static String generateSHA256Hash(String password) {
    final bytes = utf8.encode(password);
    final passwordHash = sha256.convert(bytes).toString();
    return passwordHash;
  }
}
