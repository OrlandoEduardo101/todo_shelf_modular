
import '../../../shared/utils/either/custom_either.dart';
import '../entities/user_entity.dart';
import '../entities/user_register_params.dart';
import '../errors/auth_error.dart';

abstract class IRegisterUserRepository {
  Future<CustomEither<IFailureLogin, UserEntity>> registerUser(UserRegisterParams param);
}
