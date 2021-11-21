import 'package:shelf/shelf.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_auth_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';

abstract class IAuthenticationUserRepository {
  Future<CustomEither<IFailureLogin, UserEntity>> authenticationUser(UserAuthParams param);
}
