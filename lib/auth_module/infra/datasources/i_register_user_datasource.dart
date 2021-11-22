
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/user_register_params.dart';

abstract class IRegisterUserDatasource {
  Future<UserEntity> registerUser(UserRegisterParams param);
}
