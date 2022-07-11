import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';

import '../../domain/entities/todo_entity.dart';
import '../../domain/errors/todo_error.dart';
import '../../domain/repositories/i_update_todo_repository.dart';
import '../../domain/usecases/update_todo_usecase.dart';
import '../datasources/i_update_todo_datasource.dart'; 

class UpdateTodoRepository implements IUpdateTodoRepository {
  final IUpdateTodoDatasource _datasource;

  UpdateTodoRepository(this._datasource);
  @override
  UpdateTodoResponse updateTodo(TodoEntity param) async {
    try {
      final result = await _datasource.updateTodo(param);
      return SuccessResponse(result);
    } on IFailureTodo catch (error, stacktrace) {
      return FailureResponse(
        SaveTodoDatabaseError(
          message: error.message,
          exception: error,
          stackTrace: stacktrace,
          label: 'UpdateTodoRepository-UpdateTodo',
        ),
      );
    }
  }
}
