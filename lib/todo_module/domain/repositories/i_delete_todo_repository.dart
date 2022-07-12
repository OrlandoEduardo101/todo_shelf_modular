import '../usecases/delete_todo_usecase.dart';

abstract class IDeleteTodoRepository {
  DeleteTodoResponse deleteTodo(int id);
}
