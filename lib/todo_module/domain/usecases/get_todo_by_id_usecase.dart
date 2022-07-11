import '../../../shared/utils/either/custom_either.dart';
import '../entities/todo_entity.dart';
import '../errors/todo_error.dart';
import '../repositories/i_get_todo_by_id_repository.dart';

typedef GetTodoByIdResponse = Future<CustomEither<IFailureTodo, TodoEntity
>>;

abstract class IGetTodoByIdUsecase {
  GetTodoByIdResponse call(int userId);
}

class GetTodoByIdUsecase implements IGetTodoByIdUsecase {
  final IGetTodoByIdRepository _repository;

  GetTodoByIdUsecase(this._repository);

  @override
  GetTodoByIdResponse call(int userId) async { 
    return _repository.getTodoById(userId);
  }
}
