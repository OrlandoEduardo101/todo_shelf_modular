import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';
import 'package:todo_shelf_modular/todo_module/domain/entities/todo_entity.dart';
import 'package:todo_shelf_modular/todo_module/domain/errors/todo_error.dart';
import 'package:todo_shelf_modular/todo_module/domain/repositories/i_update_todo_repository.dart';
import 'package:todo_shelf_modular/todo_module/domain/usecases/update_todo_usecase.dart';


class UpdateTodoMock extends Mock implements IUpdateTodoRepository {}

main() {
  late IUpdateTodoUsecase usecase;
  late IUpdateTodoRepository repository;

  setUpAll(() {
    repository = UpdateTodoMock();
    usecase = UpdateTodoUsecase(repository);
    registerFallbackValue(TodoEntity());
  });

  final params = TodoEntity(name: 'teste');
  final response = TodoEntity();

  test('must return TodoEntity', () async {
    when(() => repository.updateTodo(any())).thenAnswer((invocation) async =>
        SuccessResponse<IFailureTodo, TodoEntity>(response));

    var result = await usecase(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<TodoEntity>());
  });

  test('must return IFailureTodo from repository', () async {
    when(() => repository.updateTodo(any())).thenAnswer((invocation) async =>
        FailureResponse<IFailureTodo, TodoEntity>(SaveTodoDatabaseError()));

    var result = await usecase(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<IFailureTodo>());
  });
}
