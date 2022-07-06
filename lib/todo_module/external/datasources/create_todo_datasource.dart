import 'package:todo_shelf_modular/shared/services/database_service.dart';
import 'package:todo_shelf_modular/shared/services/database_error.dart';

import '../../domain/entities/todo_entity.dart';
import '../../domain/errors/todo_error.dart';
import '../../infra/datasources/i_create_todo_datasource.dart';
import '../mappers/todo_entity_mapper.dart';

class CreateTodoDatasource implements ICreateTodoDatasource {
  final DatabaseService _database;

  CreateTodoDatasource(this._database);
  @override
  Future<TodoEntity> createTodo(TodoEntity param) async {
    try {
      String sql =
          "insert into todos (name, done, updateAt, createAt, deadlineAt) values (@name, @done, @updateAt, @createAt, @deadlineAt) returning id, name, done, updateAt, createAt, deadlineAt";
      final result =
          await _database.query(sql, values: TodoEntityMapper().toMap(param));
      return TodoEntityMapper().fromMap(result[0]['todos']);
    } on IDatabaseError catch (e, s) {
      throw SaveTodoDatabaseError(
          message: e.message ?? '', exception: e, stackTrace: s);
    } catch (e) {
      rethrow;
    }
  }
}
