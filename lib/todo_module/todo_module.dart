import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import 'domain/usecases/create_todo_usecase.dart';
import 'external/datasources/create_todo_datasource.dart';
import 'infra/repositories/create_todo_repository.dart';
import 'presenter/create_todo_controller.dart';

class TodoModule extends Module {
  @override
  List<Bind> get binds => [
        //domain
        Bind.scoped((i) => CreateTodoUsecase(i())),

        //infra
        Bind.scoped((i) => CreateTodoRepository(i())),

        //external
        Bind.scoped((i) => CreateTodoDatasource(i())),

        //presenter
        Bind.scoped((i) => CreateTodoController(i(), i())),
      ];

  @override
  List<Route> get routes => [
        Route.get('/', () => Response.ok('OK!')),
        Route.get('/todoList', (ModularArguments args) => getTodoList(args)),
        Route.get(
            '/todoById/:id', (ModularArguments args) => getTodoById(args)),
        Route.post('/createTodo', (ModularArguments args, Request request) => createTodo(args, request)),
        Route.put(
            '/updateTodo/:id', (ModularArguments args) => updateTodo(args)),
        Route.delete(
            '/deleteTodo/:id', (ModularArguments args) => deleteTodo(args)),
      ];

  FutureOr<Response> getTodoList(ModularArguments args) => Response.ok('OK!');
  FutureOr<Response> getTodoById(ModularArguments args) => Response.ok('OK!');
  FutureOr<Response> createTodo(ModularArguments args, Request request) =>
      Modular.get<CreateTodoController>().createTodo(args, request);
  FutureOr<Response> updateTodo(ModularArguments args) => Response.ok('OK!');
  FutureOr<Response> deleteTodo(ModularArguments args) => Response.ok('OK!');
}
