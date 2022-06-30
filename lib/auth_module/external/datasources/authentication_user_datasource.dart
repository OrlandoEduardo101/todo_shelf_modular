import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/auth_module/infra/datasources/i_authentication_user_datasource.dart';
import 'package:todo_shelf_modular/shared/services/database_service.dart';
import 'package:todo_shelf_modular/shared/services/database_error.dart';

import '../../domain/entities/user_auth_params.dart';
import '../mappers/user_auth_params.dart';

class AuthenticationUserDatasource implements IAuthenticationUserDatasource {
  final DatabaseService _database;

  AuthenticationUserDatasource(this._database);
  @override
  Future<UserEntity> authenticationUser(UserAuthParams param) async {
    try {
      //TODO: query auth user
      String sql =
          "select into users (email, name, password) values (@email, @name, @password) returning id";
      final result = await _database.query(sql,
          values: UserAuthParamsMapper().toMap(param));
      return UserEntity(id: result[0]['users']['id']);
    } on IDatabaseError catch (e, s) {
      throw SaveDatabaseError(message: e.message ?? '', exception: e, stackTrace: s);
    }
  }
}
