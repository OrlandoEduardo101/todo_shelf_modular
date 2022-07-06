
import '../entities/todo_entity.dart';
import '../usecases/create_todo_usecase.dart';

abstract class ICreateTodoRepository {
  CreateTodoResponse createTodo(TodoEntity param);
}
