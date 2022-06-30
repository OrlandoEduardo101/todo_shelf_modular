import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/auth_module/external/mappers/user_entity_mapper.dart';
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
      String sql =
          "SELECT * FROM users WHERE email=@email AND passwordHash=@password LIMIT 1;";
      // select into users (email, name, password) values (@email, @name, @password) returning id";
      final result = await _database.query(sql,
          values: UserAuthParamsMapper().toMap(param));
      if (result.isEmpty) {
        throw ReadDatabaseError(message: 'invalid credentials');
      }
      //TODO: create usecase
      await updateUserDateLogin(param);
      return UserEntityMapper().fromMap(result.first['users']);
    } on IDatabaseError catch (e, s) {
      throw ReadDatabaseError(
          message: e.message ?? '', exception: e, stackTrace: s);
    }
  }

  @override
  Future<UserEntity> updateUserDateLogin(UserAuthParams param) async {
    try {
      String sql =
          "UPDATE users SET last_login = @last_login WHERE email=@email AND passwordHash=@password returning id, email, name";
      final result = await _database.query(
        sql,
        values: UserAuthParamsMapper().toMap(param),
      );
      return UserEntity(
        id: result[0]['users']['id'],
        email: result[0]['users']['email'],
        name: result[0]['users']['name'],
      );
    } on IDatabaseError catch (e, s) {
      throw SaveDatabaseError(
          message: e.message ?? '', exception: e, stackTrace: s);
    }
  }
}
