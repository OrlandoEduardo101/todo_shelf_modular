import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../domain/entities/todo_entity.dart';
import '../domain/usecases/get_todo_by_id_usecase.dart';
import '../external/mappers/todo_entity_mapper.dart';

class GetTodoByIdController {
  final GetTodoByIdUsecase _getTodoByIdUsecase;

  GetTodoByIdController(this._getTodoByIdUsecase);

  Future<Response> getTodoById(ModularArguments args, Request request) async {
    log('getTodoByToodo');
    final result =
        await _getTodoByIdUsecase(int.parse(args.queryParams['id'] ?? '-1'));
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

  Future<TodoEntity> getTodoEntity(int id) async {
    final result = await _getTodoByIdUsecase(id);
    return result.fold((failure) {
      return TodoEntity();
    }, (success) {
      return success;
    });
  }
}
