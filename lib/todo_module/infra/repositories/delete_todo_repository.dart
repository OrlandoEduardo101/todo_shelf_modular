import '../../../shared/utils/either/custom_either.dart';
import '../../domain/errors/todo_error.dart';
import '../../domain/repositories/i_delete_todo_repository.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../datasources/i_delete_todo_datasource.dart'; 

class DeleteTodoRepository implements IDeleteTodoRepository {
  final IDeleteTodoDatasource _datasource;

  DeleteTodoRepository(this._datasource);
  @override
  DeleteTodoResponse deleteTodo(int id) async {
    try {
      final result = await _datasource.deleteTodo(id);
      return SuccessResponse(result);
    } on IFailureTodo catch (error, stacktrace) {
      return FailureResponse(
        SaveTodoDatabaseError(
          message: error.message,
          exception: error,
          stackTrace: stacktrace,
          label: 'DeleteTodoRepository-DeleteTodo',
        ),
      );
    }
  }
}
