
import '../../../shared/utils/either/custom_either.dart';
import '../entities/user_auth_params.dart';
import '../entities/user_entity.dart';
import '../errors/auth_error.dart';

abstract class IAuthenticationUserRepository {
  Future<CustomEither<IFailureLogin, UserEntity>> authenticationUser(UserAuthParams param);
}
