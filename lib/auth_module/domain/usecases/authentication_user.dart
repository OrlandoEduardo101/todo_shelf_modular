import 'package:todo_shelf_modular/auth_module/domain/entities/user_auth_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/auth_module/domain/repositories/i_authentication_user_repository.dart';
import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';
import 'package:todo_shelf_modular/shared/utils/utils.dart';

abstract class IAuthenticationUser {
  Future<CustomEither<IFailureLogin, UserEntity>> call(UserAuthParams param);
}

class AuthenticationUser implements IAuthenticationUser {
  final IAuthenticationUserRepository _repository;
  final Utils utils;

  AuthenticationUser(this._repository, {this.utils = const Utils()});

  @override
  Future<CustomEither<IFailureLogin, UserEntity>> call(
      UserAuthParams param) async {
    if (param.email.isEmpty || !param.email.contains('@')) {
      return FailureResponse(LoginCredentialsError(message : 'Invalid email format'));
    }
    if (param.password.isEmpty || param.password.length < 6) {
      return FailureResponse(LoginCredentialsError(message : 'Invalid password format'));
    }
    return _repository.authenticationUser(param);
  }
}
