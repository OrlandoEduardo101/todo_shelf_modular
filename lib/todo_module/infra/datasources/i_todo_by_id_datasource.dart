
import '../../domain/entities/todo_entity.dart';

abstract class IGetTodoByIdDatasource {
  Future<TodoEntity> getTodoById(int id);
}
