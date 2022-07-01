import 'package:test/test.dart';
import 'package:todo_shelf_modular/todo_module/domain/entities/todo_entity.dart';
import 'package:todo_shelf_modular/todo_module/domain/errors/todo_error.dart';
import 'package:todo_shelf_modular/todo_module/external/mappers/todo_entity_mapper.dart';

void main() {
  var mapper = TodoEntityMapper();


  group('from map teste', () {
    test('must return TodoEntity without erros', () async {
      expect(mapper.fromMap(response), isA<TodoEntity>());
    });

    test('must return MapperTodoDatabaseError from error type', () async {
      expect(
          () => mapper.fromMap({
            'name': 0,
            'id': 0,
            'done': true,
          }),
          throwsA(isA<MapperTodoDatabaseError>()));
    });

    test('must return MapperTodoDatabaseError from null', () async {
      expect(
          () => mapper.fromMap({
            'id': null
          }),
          throwsA(isA<MapperTodoDatabaseError>()));
    });
  });

  group('to map teste', () {
    test('must return a map', () {
      expect(mapper.toMap(const TodoEntity()), isA<Map<String, dynamic>>());
    });
  });
}

final response = {
  'name': 'name',
  'id': 0,
  'done': true,
};
