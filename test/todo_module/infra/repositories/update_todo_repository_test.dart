import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo_shelf_modular/todo_module/domain/entities/todo_entity.dart';
import 'package:todo_shelf_modular/todo_module/domain/errors/todo_error.dart';
import 'package:todo_shelf_modular/todo_module/domain/repositories/i_update_todo_repository.dart';
import 'package:todo_shelf_modular/todo_module/infra/datasources/i_update_todo_datasource.dart';
import 'package:todo_shelf_modular/todo_module/infra/repositories/update_todo_repository.dart';


class UpdateTodoMock extends Mock implements IUpdateTodoDatasource {}

main() {
  late IUpdateTodoRepository repository;
  late IUpdateTodoDatasource datasource;

  setUpAll(() {
    datasource = UpdateTodoMock();
    repository = UpdateTodoRepository(datasource);
    registerFallbackValue(TodoEntity());
  });

  final response = TodoEntity();
  final params = TodoEntity();

  test('must return TodoEntity', () async {
    when(() => datasource.updateTodo(any()))
        .thenAnswer((invocation) async => (response));

    var result = await repository.updateTodo(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<TodoEntity>());
  });

  test('must return IFailureTodo from daatsource', () async {
    when(() => datasource.updateTodo(params))
        .thenThrow(SaveTodoDatabaseError());

    var result = await repository.updateTodo(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<IFailureTodo>());
  });
}
