import '../../../shared/services/database_error.dart';
import '../../../shared/services/database_service.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/errors/todo_error.dart';
import '../../infra/datasources/i_list_todo_datasource.dart';
import '../mappers/todo_entity_mapper.dart';

class ListTodoDatasource implements IListTodoDatasource {
  final DatabaseService _database;

  ListTodoDatasource(this._database);
  @override
  Future<List<TodoEntity>> listTodo(int param) async {
    try {
      String sql = "SELECT * FROM todos WHERE userId = @userId";
      final result = await _database.query(sql, values: {
        'userId': param,
      });
      final todoList = <TodoEntity>[];

      for (var element in result) {
        todoList.add(TodoEntityMapper().fromMap(element['todos']));
      }
      return todoList;
    } on IDatabaseError catch (e, s) {
      throw SaveTodoDatabaseError(
          message: e.message ?? '', exception: e, stackTrace: s);
    } catch (e) {
      rethrow;
    }
  }
}
