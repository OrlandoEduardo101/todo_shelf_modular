import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../domain/usecases/delete_todo_usecase.dart';

class DeleteTodoController {
  final IDeleteTodoUsecase _deleteTodoUsecase;

  DeleteTodoController(this._deleteTodoUsecase);

  Future<Response> deleteTodo(ModularArguments args, Request request) async {
    log('deleteTodo');
    final result =
        await _deleteTodoUsecase(int.parse(args.queryParams['id'] ?? '-1'));
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
      if (success) {
        return Response.ok(jsonEncode(
            {'succes': success, 'message': 'Todo deleted with succes'}));
      } else {
        return Response.ok(
            jsonEncode({'succes': success, 'message': 'Todo not deleted'}));
      }
    });
  }
}
