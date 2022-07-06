import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:todo_shelf_modular/todo_module/domain/entities/todo_entity.dart';
import 'package:todo_shelf_modular/todo_module/domain/usecases/create_todo_usecase.dart';
import 'package:todo_shelf_modular/todo_module/external/mappers/todo_entity_mapper.dart';

class CreateTodoController {
  final CreateTodoUsecase _createTodoUsecase;

  CreateTodoController(this._createTodoUsecase);

  Future<Response> createTodo(ModularArguments args) async {
    log('createTodo');
    final result = await _createTodoUsecase(TodoEntity(
      name: args.data['name'] ?? 'Untitled',
      done: args.data['done'] ?? false,
      createAt: args.data['createAt'] == null
          ? DateTime.now()
          : DateTime.tryParse(args.data['createAt']) ?? DateTime.now(),
      updateAt: args.data['updateAt'] == null
          ? DateTime.now()
          : DateTime.tryParse(args.data['updateAt']) ?? DateTime.now(),
      deadlineAt: args.data['deadlineAt'] == null
          ? DateTime.now().add(Duration(days: 8))
          : DateTime.tryParse(args.data['deadlineAt']) ??
              DateTime.now().add(Duration(days: 8)),
    ));
    return result.fold((failure) {
      if (failure.message.contains('duplicate key')) {
        return Response(
          403,
          body: jsonEncode({
            'auth': false,
            'message': 'Athententication failed',
            'database-message': failure.message
          }),
        );
      }
      if (failure.message.contains('null value')) {
        return Response(
          400,
          body: jsonEncode({'succes': false, 'message': failure.message}),
        );
      }
      return Response.notFound(
          jsonEncode({'succes': false, 'message': failure.message}));
    }, (success) {
      return Response.ok(TodoEntityMapper().toJson(success));
    });
  }
}
