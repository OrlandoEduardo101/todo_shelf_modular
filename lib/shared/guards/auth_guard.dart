import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../services/jwt_service.dart';

class AuthGuard implements ModularMiddleware {
  final IJwtService _jwtDecoder;

  AuthGuard(this._jwtDecoder);

  @override
  Handler call(Handler handler, [ModularRoute? route]) {
    return (request) {
      if (request.headers['Authorization'] == null) {
        return Response.forbidden(jsonEncode({'error': 'Not authorized'}));
      }
      final accessToken = request.headers['Authorization']!.split(' ').last;
      final Map<String, dynamic> decodedToken = _jwtDecoder.decode(accessToken);
      final isExpired = DateTime.parse(decodedToken['exp'].toString())
          .isBefore(DateTime.now());
      if (accessToken.isEmpty || !_jwtDecoder.validateJwt(accessToken) || isExpired) {
        return Response(401, body:  jsonEncode({'error': 'Not authorized'}));
      }
      return handler(request);
    };
  }

  @override
  FutureOr<Route?> pos(ModularRoute route, Request data) async {
    print(route);
    return route as Route;
  }

  @override
  FutureOr<ModularRoute?> pre(ModularRoute route) {
    return route;
  }
}
