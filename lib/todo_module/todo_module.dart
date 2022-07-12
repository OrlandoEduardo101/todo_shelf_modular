import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import 'domain/usecases/create_todo_usecase.dart';
import 'domain/usecases/delete_todo_usecase.dart';
import 'domain/usecases/get_todo_by_id_usecase.dart';
import 'domain/usecases/list_todo_usecase.dart';
import 'domain/usecases/update_todo_usecase.dart';
import 'external/datasources/create_todo_datasource.dart';
import 'external/datasources/delete_todo_datasource.dart';
import 'external/datasources/get_todo_by_id_datasource.dart';
import 'external/datasources/list_todo_datasource.dart';
import 'external/datasources/update_todo_datasource.dart';
import 'infra/repositories/create_todo_repository.dart';
import 'infra/repositories/delete_todo_repository.dart';
import 'infra/repositories/get_todo_by_id_repository.dart';
import 'infra/repositories/list_todo_repository.dart';
import 'infra/repositories/update_todo_repository.dart';
import 'presenter/create_todo_controller.dart';
import 'presenter/delete_todo_controller.dart';
import 'presenter/get_todo_by_id_controller.dart';
import 'presenter/list_todo_controller.dart';
import 'presenter/update_todo_controller.dart';

class TodoModule extends Module {
  @override
  List<Bind> get binds => [
        //domain
        Bind.scoped((i) => CreateTodoUsecase(i())),
        Bind.scoped((i) => UpdateTodoUsecase(i())),
        Bind.scoped((i) => ListTodoUsecase(i())),
        Bind.scoped((i) =>DeleteTodoUsecase(i())),
        Bind.scoped((i) => GetTodoByIdUsecase(i())),

        //infra
        Bind.scoped((i) => CreateTodoRepository(i())),
        Bind.scoped((i) => UpdateTodoRepository(i())),
        Bind.scoped((i) => ListTodoRepository(i())),
        Bind.scoped((i) => DeleteTodoRepository(i())),
        Bind.scoped((i) => GetTodoByIdRepository(i())),

        //external
        Bind.scoped((i) => CreateTodoDatasource(i())),
        Bind.scoped((i) => UpdateTodoDatasource(i())),
        Bind.scoped((i) => ListTodoDatasource(i())),
        Bind.scoped((i) => DeleteTodoDatasource(i())),
        Bind.scoped((i) => GetTodoByIdDatasource(i())),

        //presenter
        Bind.scoped((i) => CreateTodoController(i(), i())),
        Bind.scoped((i) => GetTodoByIdController(i())),
        Bind.scoped((i) => UpdateTodoController(i(), i(), i())),
        Bind.scoped((i) => ListTodoController(i(), i())),
        Bind.scoped((i) => DeleteTodoController(i())),
      ];

  @override
  List<Route> get routes => [
        Route.get('/', () => Response.ok('OK!')),
        Route.get(
            '/todoList',
            (ModularArguments args, Request request) =>
                getTodoList(args, request)),
        Route.get(
            '/todoById',
            (ModularArguments args, Request request) =>
                getTodoById(args, request)),
        Route.post(
            '/createTodo',
            (ModularArguments args, Request request) =>
                createTodo(args, request)),
        Route.path(
            '/updateTodo',
            (ModularArguments args, Request request) =>
                updateTodo(args, request)),
        Route.delete(
            '/deleteTodo', (ModularArguments args, Request request) => deleteTodo(args, request)),
      ];

  FutureOr<Response> getTodoList(ModularArguments args, Request request) => Modular.get<ListTodoController>().listTodos(args, request);
  FutureOr<Response> getTodoById(ModularArguments args, Request request) => Modular.get<GetTodoByIdController>().getTodoById(args, request);
  FutureOr<Response> createTodo(ModularArguments args, Request request) => Modular.get<CreateTodoController>().createTodo(args, request);
  FutureOr<Response> updateTodo(ModularArguments args, Request request) => Modular.get<UpdateTodoController>().updateTodo(args, request);
  FutureOr<Response> deleteTodo(ModularArguments args, Request request) => Modular.get<DeleteTodoController>().deleteTodo(args, request);
}
