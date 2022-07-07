
import '../../domain/entities/todo_entity.dart';

abstract class IListTodoDatasource {
  Future<List<TodoEntity>> listTodo(int param);
}
