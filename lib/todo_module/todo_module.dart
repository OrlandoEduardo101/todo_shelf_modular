import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
class TodoModule extends Module {

  @override
  List<Bind> get binds => [
        //domain
        // Bind.scoped((i) => TodoenticationUser(i())),

        //infra

        //domain

        //presenter
      ];

  @override
  List<Route> get routes => [
        Route.get('/', () => Response.ok('OK!')),
        Route.get('/todoList', (ModularArguments args) => getTodoList(args)),
        Route.get('/todoById/:id', (ModularArguments args) => getTodoById(args)),
        Route.post('/createTodo', (ModularArguments args) => createTodo(args)),
        Route.put('/updateTodo/:id', (ModularArguments args) => updateTodo(args)), 
        Route.delete('/deleteTodo/:id', (ModularArguments args) => deleteTodo(args)), 
      ];

  FutureOr<Response> getTodoList(ModularArguments args) => Response.ok('OK!');
  FutureOr<Response> getTodoById(ModularArguments args) => Response.ok('OK!');
  FutureOr<Response> createTodo(ModularArguments args) => Response.ok('OK!');
  FutureOr<Response> updateTodo(ModularArguments args) => Response.ok('OK!');
  FutureOr<Response> deleteTodo(ModularArguments args) => Response.ok('OK!');
}
