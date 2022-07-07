import 'package:todo_shelf_modular/todo_module/domain/errors/todo_error.dart';

import '../../../shared/utils/either/custom_either.dart';
import '../entities/todo_entity.dart';
import '../repositories/i_list_todo_repository.dart';

typedef ListTodoResponse = Future<CustomEither<IFailureTodo, List<TodoEntity>>>;

abstract class IListTodoUsecase {
  ListTodoResponse call(int userId);
}

class ListTodoUsecase implements IListTodoUsecase {
  final IListTodoRepository _repository;

  ListTodoUsecase(this._repository);

  @override
  ListTodoResponse call(int userId) async { 
    return _repository.listTodo(userId);
  }
}
