import '../../../shared/utils/either/custom_either.dart';
import '../../domain/errors/todo_error.dart';
import '../../domain/repositories/i_get_todo_by_id_repository.dart';
import '../../domain/usecases/get_todo_by_id_usecase.dart';
import '../datasources/i_todo_by_id_datasource.dart';

class GetTodoByIdRepository implements IGetTodoByIdRepository {
  final IGetTodoByIdDatasource _datasource;

  GetTodoByIdRepository(this._datasource);
  @override
  GetTodoByIdResponse getTodoById(int id) async {
    try {
      final result = await _datasource.getTodoById(id);
      return SuccessResponse(result);
    } on IFailureTodo catch (error, stacktrace) {
      return FailureResponse(
        SaveTodoDatabaseError(
          message: error.message,
          exception: error,
          stackTrace: stacktrace,
          label: 'GetTodoByIdRepository-GetTodoById',
        ),
      );
    }
  }
}
