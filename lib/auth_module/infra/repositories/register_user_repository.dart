import 'package:todo_shelf_modular/auth_module/domain/entities/user_register_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/repositories/i_register_user_repository.dart';
import 'package:todo_shelf_modular/auth_module/infra/datasources/i_register_user_datasource.dart';
import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';

class RegisterUserRepository implements IRegisterUserRepository {
  final IRegisterUserDatasource _datasource;

  RegisterUserRepository(this._datasource);
  @override
  Future<CustomEither<IFailureLogin, UserEntity>> registerUser(UserRegisterParams param) async {
    try {
      final result = await _datasource.registerUser(param);
      return SuccessResponse(result);
    } on IFailureLogin catch (error, stacktrace) {
      return FailureResponse(
        LoginCredentialsError(
          message: error.message,
          exception: error,
          stackTrace: stacktrace,
          label: 'RegisterUserRepository-RegisterUser',
        ),
      );
    }
  }
  
}