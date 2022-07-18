import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../services/jwt_service.dart';

class LogGuard implements ModularMiddleware {
  LogGuard();

  @override
  Handler call(Handler handler, [ModularRoute? route]) {
    return (request) {
      log(handler.toString() + '-' + '${route?.uri}');
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
