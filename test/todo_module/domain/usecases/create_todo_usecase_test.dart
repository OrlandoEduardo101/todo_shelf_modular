import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';
import 'package:todo_shelf_modular/todo_module/domain/entities/todo_entity.dart';
import 'package:todo_shelf_modular/todo_module/domain/errors/todo_error.dart';
import 'package:todo_shelf_modular/todo_module/domain/repositories/i_create_todo_repository.dart';
import 'package:todo_shelf_modular/todo_module/domain/usecases/create_todo_usecase.dart';

class CreateTodoMock extends Mock implements ICreateTodoRepository {}

main() {
  late ICreateTodoUsecase usecase;
  late ICreateTodoRepository repository;

  setUpAll(() {
    repository = CreateTodoMock();
    usecase = CreateTodoUsecase(repository);
    registerFallbackValue(TodoEntity());
  });

  final params = TodoEntity(name: 'teste');
  final paramsInvalidName = TodoEntity();
  final response = TodoEntity();

  test('must return TodoEntity', () async {
    when(() => repository.createTodo(any())).thenAnswer((invocation) async =>
        SuccessResponse<IFailureTodo, TodoEntity>(response));

    var result = await usecase(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<TodoEntity>());
  });

  test('must return IFailureTodo from name.isEmpty', () async {
    when(() => repository.createTodo(any())).thenAnswer((invocation) async =>
        SuccessResponse<IFailureTodo, TodoEntity>(response));

    var result = await usecase(paramsInvalidName);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<SaveTodoDatabaseError>());
    expect(
        result.fold(
          (l) => l.message,
          (r) => r,
        ),
        equals('Invalid email format'));
  });

  test('must return IFailureTodo from repository', () async {
    when(() => repository.createTodo(any())).thenAnswer((invocation) async =>
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
