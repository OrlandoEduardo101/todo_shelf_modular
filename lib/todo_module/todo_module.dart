import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:todo_shelf_modular/todo_module/domain/usecases/create_todo_usecase.dart';
import 'package:todo_shelf_modular/todo_module/external/datasources/create_todo_datasource.dart';
import 'package:todo_shelf_modular/todo_module/infra/repositories/create_todo_repository.dart';
import 'package:todo_shelf_modular/todo_module/presenter/create_todo_controller.dart';

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
        Bind.scoped((i) => CreateTodoController(i())),
      ];

  @override
  List<Route> get routes => [
        Route.get('/', () => Response.ok('OK!')),
        Route.get('/todoList', (ModularArguments args) => getTodoList(args)),
        Route.get(
            '/todoById/:id', (ModularArguments args) => getTodoById(args)),
        Route.post('/createTodo', (ModularArguments args) => createTodo(args)),
        Route.put(
            '/updateTodo/:id', (ModularArguments args) => updateTodo(args)),
        Route.delete(
            '/deleteTodo/:id', (ModularArguments args) => deleteTodo(args)),
      ];

  FutureOr<Response> getTodoList(ModularArguments args) => Response.ok('OK!');
  FutureOr<Response> getTodoById(ModularArguments args) => Response.ok('OK!');
  FutureOr<Response> createTodo(ModularArguments args) =>
      Modular.get<CreateTodoController>().createTodo(args);
  FutureOr<Response> updateTodo(ModularArguments args) => Response.ok('OK!');
  FutureOr<Response> deleteTodo(ModularArguments args) => Response.ok('OK!');
}
