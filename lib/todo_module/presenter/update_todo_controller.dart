import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../../shared/services/jwt_service.dart';
import '../domain/entities/todo_entity.dart';
import '../domain/usecases/update_todo_usecase.dart';
import '../external/mappers/todo_entity_mapper.dart';
import 'get_todo_by_id_controller.dart';

class UpdateTodoController {
  final UpdateTodoUsecase _updateTodoUsecase;
  final GetTodoByIdController _getTodoByIdController;
  final IJwtService _iJwtService;

  UpdateTodoController(
      this._updateTodoUsecase, this._iJwtService, this._getTodoByIdController);

  Future<Response> updateTodo(ModularArguments args, Request request) async {
    log('UpdateTodo');

    final id = int.parse(args.queryParams['id'] ?? '-1');
    final userId = _iJwtService
        .getUserId((request.headers['Authorization'] ?? 'a a').split(' ').last);

    final todoEntity = await _getTodoByIdController.getTodoEntity(id);
    final result = await _updateTodoUsecase(TodoEntity(
      name: args.data['name'] ?? todoEntity.name,
      done: args.data['done'] ?? todoEntity.done,
      id: id,
      userId: userId,
      createAt: args.data['createAt'] == null
          ? todoEntity.createAt
          : DateTime.tryParse(args.data['createAt']) ?? DateTime.now(),
      updateAt: args.data['updateAt'] == null
          ? todoEntity.updateAt
          : DateTime.tryParse(args.data['updateAt']) ?? DateTime.now(),
      deadlineAt: args.data['deadlineAt'] == null
          ? todoEntity.deadlineAt
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
