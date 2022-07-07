
import '../usecases/list_todo_usecase.dart';

abstract class IListTodoRepository {
  ListTodoResponse listTodo(int userId);
}
