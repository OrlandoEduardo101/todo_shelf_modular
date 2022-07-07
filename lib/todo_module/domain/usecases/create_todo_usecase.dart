import 'package:todo_shelf_modular/todo_module/domain/errors/todo_error.dart';

import '../../../shared/utils/either/custom_either.dart';
import '../entities/todo_entity.dart';
import '../repositories/i_create_todo_repository.dart';

typedef CreateTodoResponse = Future<CustomEither<IFailureTodo, TodoEntity>>;

abstract class ICreateTodoUsecase {
  CreateTodoResponse call(TodoEntity param);
}

class CreateTodoUsecase implements ICreateTodoUsecase {
  final ICreateTodoRepository _repository;

  CreateTodoUsecase(this._repository);

  @override
  CreateTodoResponse call(TodoEntity param) async {
    if (param.name.isEmpty) {
      return FailureResponse(
          SaveTodoDatabaseError(message: 'Invalid name format'));
    }
    return _repository.createTodo(param);
  }
}
