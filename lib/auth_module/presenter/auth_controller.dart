import 'package:shelf/shelf.dart';

class AuthController {
  const AuthController();
  Future<Response> autheticationUser() async {
    return Response.ok('OK!');
  }
}
