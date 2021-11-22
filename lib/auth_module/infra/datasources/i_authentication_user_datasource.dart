
import '../../domain/entities/user_auth_params.dart';
import '../../domain/entities/user_entity.dart';

abstract class IAuthenticationUserDatasource {
  Future<UserEntity> authenticationUser(UserAuthParams param);
}
