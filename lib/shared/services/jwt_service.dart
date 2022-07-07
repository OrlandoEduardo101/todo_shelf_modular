import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../auth_module/domain/entities/user_entity.dart';
import 'read_dot_env.dart';

abstract class IJwtService {
  Map<String, dynamic> decode(String token);
  String generateJWT(UserEntity user);
  bool validateJwt(String token);
  int getUserId(String token);
}

class JwtService implements IJwtService {
  static const String jwtKey = "TODO_POSTGRES_TEST";

  @override
  Map<String, dynamic> decode(String token) {
    return JwtDecoder.decode(token);
  }

  @override
  String generateJWT(UserEntity user) {
    final env = ReadDotEnv().env;
    final claimSet = JwtClaim(
      issuer: '${env['DB_HOST']}/${env['PORT']}', //"http://localhost:8888",
      audience: ['${env['API_HOST']}'],
      subject: user.id.toString(),
      jwtId: user.id.toString(),
      otherClaims: <String, dynamic>{},
      maxAge: const Duration(days: 1),
    );
    final token = "Bearer ${issueJwtHS256(claimSet, jwtKey)}";
    return token;
  }

  @override
  bool validateJwt(String token) {
    final env = ReadDotEnv().env;
    try {
      final JwtClaim decClaimSet = verifyJwtHS256Signature(token, jwtKey);
      // print(decClaimSet);

      decClaimSet.validate(
          issuer: '${env['DB_HOST']}/${env['PORT']}',
          audience: '${env['API_HOST']}');

      if (decClaimSet.jwtId != null) {
        print(decClaimSet.jwtId);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  int getUserId(String token) {
    final JwtClaim decClaimSet = verifyJwtHS256Signature(token, jwtKey);
    return int.parse(decClaimSet.jwtId ?? '-1');
  }
}
