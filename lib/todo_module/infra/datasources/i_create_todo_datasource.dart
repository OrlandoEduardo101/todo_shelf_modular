
import 'package:todo_shelf_modular/todo_module/domain/entities/todo_entity.dart';

import '../../domain/entities/todo_entity.dart';

abstract class ICreateTodoDatasource {
  Future<TodoEntity> createTodo(TodoEntity param);
}
