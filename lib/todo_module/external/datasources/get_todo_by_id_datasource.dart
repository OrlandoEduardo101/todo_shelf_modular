import '../../../shared/services/database_error.dart';
import '../../../shared/services/database_service.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/errors/todo_error.dart';
import '../../infra/datasources/i_todo_by_id_datasource.dart';
import '../mappers/todo_entity_mapper.dart';

class GetTodoByIdDatasource implements IGetTodoByIdDatasource {
  final DatabaseService _database;

  GetTodoByIdDatasource(this._database);
  @override
  Future<TodoEntity> getTodoById(int param) async {
    try {
      String sql = "SELECT * FROM todos WHERE id = @id";
      final result = await _database.query(sql, values: {
        'id': param,
      });
      return TodoEntityMapper().fromMap(result[0]['todos']);
    } on IDatabaseError catch (e, s) {
      throw SaveTodoDatabaseError(
        message: e.message ?? '',
        exception: e,
        stackTrace: s,
      );
    } catch (e) {
      rethrow;
    }
  }
}
