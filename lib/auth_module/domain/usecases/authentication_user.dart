import 'package:shelf/shelf.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_auth_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/auth_module/domain/repositories/i_authentication_user_repository.dart';
import 'package:todo_shelf_modular/auth_module/external/mappers/user_entity_mapper.dart';
import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';
import 'package:todo_shelf_modular/shared/utils/utils.dart';

abstract class IAuthenticationUser {
  Future<CustomEither<IFailureLogin, Response>> call(UserAuthParams param);
}

class AuthenticationUser implements IAuthenticationUser {
  final IAuthenticationUserRepository _repository;
  final Utils utils;

  AuthenticationUser(this._repository, {this.utils = const Utils()});

  @override
  Future<CustomEither<IFailureLogin, Response>> call(
      UserAuthParams param) async {
    final result = await _repository.authenticationUser(param);
  

    return result.fold((failure) => SuccessResponse(Response.notFound({'auth': false, 'message': failure.message})), (success) {
      final jwt = Utils.generateJWT(success);
      return SuccessResponse(Response.ok(UserEntityMapper().toMap(success.copyWith(token: jwt))));
    });
  }
}
