import '../../../shared/utils/either/custom_either.dart';
import '../../domain/errors/todo_error.dart';
import '../../domain/repositories/i_list_todo_repository.dart';
import '../../domain/usecases/list_todo_usecase.dart';
import '../datasources/i_list_todo_datasource.dart';

class ListTodoRepository implements IListTodoRepository {
  final IListTodoDatasource _datasource;

  ListTodoRepository(this._datasource);
  @override
  ListTodoResponse listTodo(int userId) async {
    try {
      final result = await _datasource.listTodo(userId);
      return SuccessResponse(result);
    } on IFailureTodo catch (error, stacktrace) {
      return FailureResponse(
        ReadTodoDatabaseError(
          message: error.message,
          exception: error,
          stackTrace: stacktrace,
          label: 'ListTodoRepository-ListTodo',
        ),
      );
    }
  }
}
