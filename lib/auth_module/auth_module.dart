import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import 'presenter/auth_controller.dart';

class AuthModule extends Module {

  @override
  List<Bind> get binds => [
    Bind.scoped((i) => AuthController())
  ];

  @override
  List<Route> get routes => [
        Route.post('/', () => getAllUsers),
      ];

      FutureOr<Response> getAllUsers() =>  AuthController().autheticationUser();
}