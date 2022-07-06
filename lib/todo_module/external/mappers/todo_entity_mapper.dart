import 'dart:convert';

import 'package:todo_shelf_modular/shared/contracts/i_mapper.dart';

import '../../domain/entities/todo_entity.dart';
import '../../domain/errors/todo_error.dart';

class TodoEntityMapper implements IMapper<TodoEntity> {
  @override
  Map<String, dynamic> toMap(TodoEntity object) {
    try {
      return {
        'id': object.id,
        'name': object.name,
        'done': object.done,
        'createAt': object.createAt?.toIso8601String(),
        'deadlineAt': object.deadlineAt?.toIso8601String(),
        'updateAt': object.updateAt?.toIso8601String(),
      };
    } catch (e, s) {
      throw MapperTodoDatabaseError(exception: e, stackTrace: s);
    }
  }

  @override
  TodoEntity fromMap(Map<String, dynamic> map) {
    try {
      return TodoEntity(
        id: map['id'],
        name: map['name'],
        done: map['done'],
        updateAt: map['updateAt'],
        deadlineAt: map['deadlineAt'],
        createAt: map['createAt'],
      );
    } catch (e, s) {
      throw MapperTodoDatabaseError(exception: e, stackTrace: s);
    }
  }

  String toJson(TodoEntity object) => json.encode(toMap(object));

  TodoEntity fromJson(String source) => fromMap(json.decode(source));

  @override
  void checkJson(Map<String, dynamic> json) {}
}
