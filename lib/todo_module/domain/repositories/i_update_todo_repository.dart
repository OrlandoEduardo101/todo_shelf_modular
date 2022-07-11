import '../entities/todo_entity.dart';
import '../usecases/update_todo_usecase.dart';

abstract class IUpdateTodoRepository {
  UpdateTodoResponse updateTodo(TodoEntity param);
}
