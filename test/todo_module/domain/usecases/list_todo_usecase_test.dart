import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';
import 'package:todo_shelf_modular/todo_module/domain/entities/todo_entity.dart';
import 'package:todo_shelf_modular/todo_module/domain/errors/todo_error.dart';
import 'package:todo_shelf_modular/todo_module/domain/repositories/i_list_todo_repository.dart';
import 'package:todo_shelf_modular/todo_module/domain/usecases/list_todo_usecase.dart';


class ListTodoMock extends Mock implements IListTodoRepository {}

main() {
  late IListTodoUsecase usecase;
  late IListTodoRepository repository;

  setUpAll(() {
    repository = ListTodoMock();
    usecase = ListTodoUsecase(repository);
  });

  final params = 1;
  final response = [TodoEntity()];

  test('must return TodoEntity', () async {
    when(() => repository.listTodo(any())).thenAnswer((invocation) async =>
        SuccessResponse<IFailureTodo, List<TodoEntity>>(response));

    var result = await usecase(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<TodoEntity>());
  }); 
  test('must return IFailureTodo from repository', () async {
    when(() => repository.listTodo(any())).thenAnswer((invocation) async =>
        FailureResponse<IFailureTodo, List<TodoEntity>>(SaveTodoDatabaseError()));

    var result = await usecase(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<IFailureTodo>());
  });
}
