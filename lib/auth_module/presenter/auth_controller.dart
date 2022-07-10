import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_auth_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_register_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/usecases/authentication_user.dart';
import 'package:todo_shelf_modular/auth_module/domain/usecases/refresh_token.dart';
import 'package:todo_shelf_modular/auth_module/domain/usecases/register_user.dart';
import 'package:todo_shelf_modular/auth_module/external/mappers/refresh_token_entity_mapper.dart';
import 'package:todo_shelf_modular/auth_module/external/mappers/user_entity_mapper.dart';
import 'package:todo_shelf_modular/auth_module/presenter/auth_messages.dart';
import 'package:todo_shelf_modular/shared/utils/utils.dart';

import '../../shared/services/jwt_service.dart';

class AuthController {
  const AuthController(
    this._authenticationUser,
    this._registerUser,
    this._refreshToken,
    this._iJwtService,
  );

  final IAuthenticationUser _authenticationUser;
  final IRegisterUser _registerUser;
  final IRefreshToken _refreshToken;
  final IJwtService _iJwtService;

  Future<Response> autheticationUser(ModularArguments args) async {
    final passwordHash = Utils.generateSHA256Hash(args.data['password']);
    final result = await _authenticationUser(UserAuthParams(
        email: args.data['email'],
        password: passwordHash,
        lastLogin: DateTime.now()));
    return result.fold((failure) {
      if (failure.message.contains('invalid credentials')) {
        return Response(
          403,
          body: jsonEncode({
            'auth': false,
            'message': AuthMessages.invalidUserCredentials,
            'database-message': failure.message
          }),
        );
      }

      return Response.notFound(jsonEncode({'auth': false, 'message': failure.message}));
    }, (success) {
      final jwt = _iJwtService.generateJWT(success);
      final refreshJwt =
          _iJwtService.generateJWT(success, maxAge: const Duration(days: 15));
      return Response.ok(UserEntityMapper().toJson(success.copyWith(
          token: jwt, refreshToken: refreshJwt, tokenType: 'Bearer')));
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
          body: jsonEncode({
            'auth': false,
            'message': AuthMessages.userAlreadyRegistred,
            'database-message': failure.message
          }),
        );
      }
      if (failure.message.contains('null value')) {
        return Response(
          400,
          body: jsonEncode({'auth': false, 'message': failure.message}),
        );
      }
      return Response.notFound(
          jsonEncode({'auth': false, 'message': failure.message}));
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

  Future<Response> refreshToken(ModularArguments args) async {
    final result = await _refreshToken(args.queryParams['refreshToken'] ?? '');
    return result.fold((failure) {
      return Response.forbidden(
          jsonEncode({'auth': false, 'message': failure.message, 'label': failure.label}));
    }, (success) {
      return Response.ok(RefreshTokenEntityMapper().toJson(success));
    });
  }
}
