import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:todo_shelf_modular/auth_module/domain/usecases/authentication_user.dart';
import 'package:todo_shelf_modular/auth_module/external/datasources/register_user_datasource.dart';
import 'package:todo_shelf_modular/auth_module/infra/repositories/authentication_user_repository.dart';
import 'package:todo_shelf_modular/auth_module/infra/repositories/register_user_repository.dart';

import 'domain/usecases/register_user.dart';
import 'external/datasources/authentication_user_datasource.dart';
import 'presenter/auth_controller.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        //domain
        Bind.scoped((i) => AuthenticationUser(i())),
        Bind.scoped((i) => RegisterUser(i())),

        //infra
        Bind.scoped((i) => AuthenticationUserRepository(i())),
        Bind.scoped((i) => RegisterUserRepository(i())),

        //domain
        Bind.scoped((i) => AuthenticationUserDatasource(i())),
        Bind.scoped((i) => RegisterUserDatasource(i())),

        //presenter
        Bind.scoped((i) => AuthController(i(), i(), i())),
      ];

  @override
  List<Route> get routes => [
        Route.get('/', () => Response.ok('OK!')),
        Route.post(
            '/login', (ModularArguments args) => authenticationUser(args)),
        Route.post('/register', (ModularArguments args) => registerUser(args)),
        Route.post('/registerAndAuth',
            (ModularArguments args) => registerAndAuthenticationUser(args)),
      ];

  FutureOr<Response> authenticationUser(ModularArguments args) =>
      Modular.get<AuthController>().autheticationUser(args);
  FutureOr<Response> registerUser(ModularArguments args) =>
      Modular.get<AuthController>().registerUser(args);
  FutureOr<Response> registerAndAuthenticationUser(ModularArguments args) =>
      Modular.get<AuthController>().registerAndAthenticationUser(args);
}
