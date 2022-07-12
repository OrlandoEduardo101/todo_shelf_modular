import 'package:todo_shelf_modular/todo_module/domain/errors/todo_error.dart';

import '../../../shared/utils/either/custom_either.dart';
import '../entities/todo_entity.dart';
import '../repositories/i_update_todo_repository.dart';

typedef UpdateTodoResponse = Future<CustomEither<IFailureTodo, TodoEntity>>;

abstract class IUpdateTodoUsecase {
  UpdateTodoResponse call(TodoEntity param);
}

class UpdateTodoUsecase implements IUpdateTodoUsecase {
  final IUpdateTodoRepository _repository;

  UpdateTodoUsecase(this._repository);

  @override
  UpdateTodoResponse call(TodoEntity param) async {
    return _repository.updateTodo(param);
  }
}
