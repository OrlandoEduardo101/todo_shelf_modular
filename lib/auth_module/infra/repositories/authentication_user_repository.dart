import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_auth_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/repositories/i_authentication_user_repository.dart';
import 'package:todo_shelf_modular/auth_module/infra/datasources/i_authentication_user_datasource.dart';
import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';

class AuthenticationUserRepository implements IAuthenticationUserRepository {
  final IAuthenticationUserDatasource _datasource;

  AuthenticationUserRepository(this._datasource);
  @override
  Future<CustomEither<IFailureLogin, UserEntity>> authenticationUser(UserAuthParams param) async {
    try {
      final result = await _datasource.authenticationUser(param);
      return SuccessResponse(result);
    } on IFailureLogin catch (error, stacktrace) {
      return FailureResponse(
        LoginCredentialsError(
          message: error.message,
          exception: error,
          stackTrace: stacktrace,
          label: 'AuthenticationUserRepository-authenticationUser',
        ),
      );
    }
  }
  
}