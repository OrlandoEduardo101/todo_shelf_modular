import 'package:mocktail/mocktail.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';
import 'package:todo_shelf_modular/shared/services/database_error.dart';
import 'package:todo_shelf_modular/shared/services/database_service.dart';
import 'package:todo_shelf_modular/todo_module/domain/entities/todo_entity.dart';
import 'package:todo_shelf_modular/todo_module/domain/errors/todo_error.dart';
import 'package:todo_shelf_modular/todo_module/external/datasources/create_todo_datasource.dart';
import 'package:todo_shelf_modular/todo_module/external/mappers/todo_entity_mapper.dart';
import 'package:todo_shelf_modular/todo_module/infra/datasources/i_create_todo_datasource.dart';

class DataBaseMock extends Mock implements DatabaseService {}

void main() {
  late final ICreateTodoDatasource datasource;
  late final DatabaseService databaseService;

  final date = DateTime.now();
  final params = TodoEntity(
    createAt: date,
    deadlineAt: date.add(Duration(days: 1)),
    updateAt: date,
    name: 'teste',
    done: false,
  );
  setUpAll(() {
    registerFallbackValue(params);
  });

  setUp(() {
    databaseService = DataBaseMock();
    datasource = CreateTodoDatasource(databaseService);
  });

  test('must return TodoEntity with succes after write in data base', () async {
    when(() => databaseService.query(any(), values: any(named: 'values')))
        .thenAnswer((invocation) async => [
              {
                'todos': {
                  'createAt': date,
                  'deadlineAt': date.add(Duration(days: 1)),
                  'updateAt': date,
                  'name': 'teste',
                  'done': false,
                  'id': 1
                }
              }
            ]);

    final result = await datasource.createTodo(params);

    expect(result, isA<TodoEntity>());
    expect(result.id, equals(1));
  });

  test('must throws SaveTodoDatabaseError when IDatabaseError', () async {
    when(() => databaseService.query(any(), values: any(named: 'values')))
        .thenThrow(ErrorToQuery());

    expect(() => datasource.createTodo(params),
        throwsA(isA<SaveTodoDatabaseError>()));
  });
}
