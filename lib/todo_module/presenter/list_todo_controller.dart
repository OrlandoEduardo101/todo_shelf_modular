import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../../shared/services/jwt_service.dart';
import '../domain/usecases/list_todo_usecase.dart';
import '../external/mappers/todo_entity_mapper.dart';

class ListTodoController {
  final ListTodoUsecase _listTodoUsecase;
  final IJwtService _iJwtService;

  ListTodoController(this._listTodoUsecase, this._iJwtService);

  Future<Response> listTodos(ModularArguments args, Request request) async {
    log('listTodos');
    final result = await _listTodoUsecase(_iJwtService.getUserId(
        (request.headers['Authorization'] ?? 'a a').split(' ').last));
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
      final listMapTodos = <Map<String, dynamic>>[];

      for (var element in success) {
        listMapTodos.add(TodoEntityMapper().toMap(element));
      }
      return Response.ok(jsonEncode(listMapTodos));
    });
  }
}
