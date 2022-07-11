import '../../../shared/services/database_error.dart';
import '../../../shared/services/database_service.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/errors/todo_error.dart';
import '../../infra/datasources/i_update_todo_datasource.dart';
import '../mappers/todo_entity_mapper.dart';

class UpdateTodoDatasource implements IUpdateTodoDatasource {
  final DatabaseService _database;

  UpdateTodoDatasource(this._database);
  @override
  Future<TodoEntity> updateTodo(TodoEntity param) async {
    try {
      String sql =
          "UPDATE todos SET (name, done, updateAt, createAt, deadlineAt) values (@name, @done, @updateAt, @createAt, @deadlineAt) WHERE id=@id returning id, name, done, updateAt, createAt, deadlineAt, userId";
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
