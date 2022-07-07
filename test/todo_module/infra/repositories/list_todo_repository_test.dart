import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo_shelf_modular/todo_module/domain/entities/todo_entity.dart';
import 'package:todo_shelf_modular/todo_module/domain/errors/todo_error.dart';
import 'package:todo_shelf_modular/todo_module/domain/repositories/i_list_todo_repository.dart';
import 'package:todo_shelf_modular/todo_module/infra/datasources/i_list_todo_datasource.dart';
import 'package:todo_shelf_modular/todo_module/infra/repositories/list_todo_repository.dart';

class ListTodoMock extends Mock implements IListTodoDatasource {}

main() {
  late IListTodoRepository repository;
  late IListTodoDatasource datasource;

  setUpAll(() {
    datasource = ListTodoMock();
    repository = ListTodoRepository(datasource);
  });

  final response = [TodoEntity()];
  final params = 1;

  test('must return TodoEntity', () async {
    when(() => datasource.listTodo(any()))
        .thenAnswer((invocation) async => (response));

    var result = await repository.listTodo(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<List<TodoEntity>>());
  });

  test('must return IFailureTodo from daatsource', () async {
    when(() => datasource.listTodo(params))
        .thenThrow(ReadTodoDatabaseError());

    var result = await repository.listTodo(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<IFailureTodo>());
  });
}
