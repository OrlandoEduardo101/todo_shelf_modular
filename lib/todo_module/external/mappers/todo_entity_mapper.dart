import 'dart:convert';

import '../../../shared/contracts/i_mapper.dart';
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
        'userid': object.userId,
        'createAt': object.createAt?.toIso8601String(),
        'deadlineAt': object.deadlineAt?.toIso8601String(),
        'updateAt': object.updateAt?.toIso8601String(),
        'userId_fk': object.userId,
      }..removeWhere((key, value) => value == null && (value is String && value.isEmpty));
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
        updateAt: map['updateat'],
        deadlineAt: map['deadlineat'],
        createAt: map['createat'],
        userId: map['userid'],
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
