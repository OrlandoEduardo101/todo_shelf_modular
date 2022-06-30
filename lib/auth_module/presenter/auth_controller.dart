import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_auth_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_register_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/usecases/authentication_user.dart';
import 'package:todo_shelf_modular/auth_module/domain/usecases/register_user.dart';
import 'package:todo_shelf_modular/auth_module/external/mappers/user_entity_mapper.dart';
import 'package:todo_shelf_modular/auth_module/presenter/auth_messages.dart';
import 'package:todo_shelf_modular/shared/utils/utils.dart';

class AuthController {
  const AuthController(
    this._authenticationUser,
    this._registerUser,
  );

  final IAuthenticationUser _authenticationUser;
  final IRegisterUser _registerUser;

  Future<Response> autheticationUser(ModularArguments args) async {
    final passwordHash = Utils.generateSHA256Hash(args.data['password']);
    final result = await _authenticationUser(
        UserAuthParams(email: args.data['email'], password: passwordHash));
    return result.fold(
        (failure) =>
            Response.notFound({'auth': false, 'message': failure.message}),
        (success) {
      final jwt = Utils.generateJWT(success);
      return Response.ok(
          UserEntityMapper().toMap(success.copyWith(token: jwt)));
    });
  }

  Future<Response> registerUser(ModularArguments args) async {
    print('register');
    log('register');
    final passwordHash = Utils.generateSHA256Hash(args.data['password']);
    final result = await _registerUser(UserRegisterParams(
      email: args.data['email'],
      password: passwordHash,
      name: args.data['name'],
      createdOn: DateTime.now(),
      lastLogin: DateTime.now(),
    ));
    return result.fold((failure) {
      if (failure.message.contains('duplicate key')) {
        return Response(
          403,
          body: jsonEncode({'auth': false, 'message': AuthMessages.userAlreadyRegistred,'database-message': failure.message}),
        );
      }
      if (failure.message.contains('null value')) {
        return Response(
          400,
          body: jsonEncode({'auth': false, 'message': failure.message}),
        );
      }
      return Response.notFound(jsonEncode({'auth': false, 'message': failure.message}));
    }, (success) {
      return Response.ok(AuthMessages.cretedSucces);
    });
  }

  Future<Response> registerAndAthenticationUser(ModularArguments args) async {
    final registerResult = await registerUser(args);

    if (registerResult.statusCode == 200) {
      return await autheticationUser(args);
    }

    return registerResult;
  }
}
