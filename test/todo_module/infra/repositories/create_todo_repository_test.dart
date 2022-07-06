import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo_shelf_modular/todo_module/domain/entities/todo_entity.dart';
import 'package:todo_shelf_modular/todo_module/domain/errors/todo_error.dart';
import 'package:todo_shelf_modular/todo_module/domain/repositories/i_create_todo_repository.dart';
import 'package:todo_shelf_modular/todo_module/infra/datasources/i_create_todo_datasource.dart';
import 'package:todo_shelf_modular/todo_module/infra/repositories/create_todo_repository.dart';

class CreateTodoMock extends Mock implements ICreateTodoDatasource {}

main() {
  late ICreateTodoRepository repository;
  late ICreateTodoDatasource datasource;

  setUpAll(() {
    datasource = CreateTodoMock();
    repository = CreateTodoRepository(datasource);
    registerFallbackValue(TodoEntity());
  });

  final response = TodoEntity();
  final params = TodoEntity();

  test('must return TodoEntity', () async {
    when(() => datasource.createTodo(any()))
        .thenAnswer((invocation) async => (response));

    var result = await repository.createTodo(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<TodoEntity>());
  });

  test('must return IFailureTodo from daatsource', () async {
    when(() => datasource.createTodo(params))
        .thenThrow(SaveTodoDatabaseError());

    var result = await repository.createTodo(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<IFailureTodo>());
  });
}
