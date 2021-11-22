import 'package:todo_shelf_modular/auth_module/domain/entities/user_register_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/auth_module/external/mappers/user_register_params.dart';
import 'package:todo_shelf_modular/auth_module/infra/datasources/i_register_user_datasource.dart';
import 'package:todo_shelf_modular/shared/services/database_service.dart';
import 'package:todo_shelf_modular/shared/services/database_error.dart';

class RegisterUserDatasource implements IRegisterUserDatasource {
  final DatabaseService _database;

  RegisterUserDatasource(this._database);
  @override
  Future<UserEntity> registerUser(UserRegisterParams param) async {
    try {
      String sql =
          "insert into users (email, name, password) values (@email, @name, @password) returning id";
      final result = await _database.query(sql,
          values: UserRegisterParamsMapper().toMap(param));
      return UserEntity(id: result[0]['users']['id']);
    } on IDatabaseError catch (e, s) {
      throw SaveDatabaseError(message: e.message ?? '', exception: e, stackTrace: s);
    }
  }
}
