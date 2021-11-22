import '../../../shared/utils/either/custom_either.dart';
import '../../../shared/utils/utils.dart';
import '../entities/user_entity.dart';
import '../entities/user_register_params.dart';
import '../errors/auth_error.dart';
import '../repositories/i_register_user_repository.dart';

abstract class IRegisterUser {
  Future<CustomEither<IFailureLogin, UserEntity>> call(UserRegisterParams param);
}

class RegisterUser implements IRegisterUser {
  final IRegisterUserRepository _repository;
  final Utils utils;

  RegisterUser(this._repository, {this.utils = const Utils()});

  @override
  Future<CustomEither<IFailureLogin, UserEntity>> call(
      UserRegisterParams param) async {
    if (param.email.isEmpty || !param.email.contains('@')) {
      return FailureResponse(RegisterCredentialsError(message : 'Invalid email format'));
    }
    if (param.password.isEmpty || param.password.length < 6) {
      return FailureResponse(RegisterCredentialsError(message : 'Invalid password format'));
    }
    if (param.name.isEmpty) {
      return FailureResponse(RegisterCredentialsError(message : 'Invalid name format'));
    }
    return _repository.registerUser(param);
  }
}
