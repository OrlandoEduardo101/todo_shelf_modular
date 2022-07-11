
import 'package:todo_shelf_modular/todo_module/domain/entities/todo_entity.dart';

import '../../domain/entities/todo_entity.dart';

abstract class IUpdateTodoDatasource {
  Future<TodoEntity> updateTodo(TodoEntity param);
}
