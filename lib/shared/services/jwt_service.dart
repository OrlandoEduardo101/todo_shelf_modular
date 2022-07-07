import 'package:jwt_decoder/jwt_decoder.dart';

abstract class IJwtService {
  Map<String, dynamic> decode(String token);
}

class JwtService implements IJwtService {
  @override
  Map<String, dynamic> decode(String token) {
    return JwtDecoder.decode(token);
  }
}
