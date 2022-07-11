import '../../../shared/utils/either/custom_either.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/errors/todo_error.dart';
import '../../domain/repositories/i_create_todo_repository.dart';
import '../../domain/usecases/create_todo_usecase.dart';
import '../datasources/i_create_todo_datasource.dart';

class CreateTodoRepository implements ICreateTodoRepository {
  final ICreateTodoDatasource _datasource;
  
  CreateTodoRepository(this._datasource);
  @override
  CreateTodoResponse createTodo(TodoEntity param) async {
    try {
      final result = await _datasource.createTodo(param);
      return SuccessResponse(result);
    } on IFailureTodo catch (error, stacktrace) {
      return FailureResponse(
        SaveTodoDatabaseError(
          message: error.message,
          exception: error,
          stackTrace: stacktrace,
          label: 'CreateTodoRepository-CreateTodo',
        ),
      );
    }
  }
}
