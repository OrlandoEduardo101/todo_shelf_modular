import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:todo_shelf_modular/auth_module/domain/usecases/authentication_user.dart';

import 'domain/usecases/register_user.dart';
import 'presenter/auth_controller.dart';

class AuthModule extends Module {

  @override
  List<Bind> get binds => [

    //domain
    Bind.scoped((i) => AuthenticationUser(i())),
    Bind.scoped((i) => RegisterUser(i())),

    //presenter
    Bind.scoped((i) => AuthController(i(), i())),
  ];

  @override
  List<Route> get routes => [
        Route.post('/', (ModularArguments args) => authenticationUser),
        Route.post('/register', (ModularArguments args) => registerUser),
        Route.post('/registerAndAuth', (ModularArguments args) => registerAndAuthenticationUser),
      ];

      FutureOr<Response> authenticationUser(ModularArguments args) =>  Modular.get<AuthController>().autheticationUser(args);
      FutureOr<Response> registerUser(ModularArguments args) =>  Modular.get<AuthController>().registerUser(args);
      FutureOr<Response> registerAndAuthenticationUser(ModularArguments args) =>  Modular.get<AuthController>().registerAndAthenticationUser(args);
}