import '../../../shared/utils/either/custom_either.dart';
import '../errors/todo_error.dart';
import '../repositories/i_delete_todo_repository.dart';

typedef DeleteTodoResponse = Future<CustomEither<IFailureTodo, bool>>;

abstract class IDeleteTodoUsecase {
  DeleteTodoResponse call(int id);
}

class DeleteTodoUsecase implements IDeleteTodoUsecase {
  final IDeleteTodoRepository _repository;

  DeleteTodoUsecase(this._repository);

  @override
  DeleteTodoResponse call(int id) async {
    return _repository.deleteTodo(id);
  }
}
