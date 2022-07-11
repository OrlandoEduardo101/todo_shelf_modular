
import '../usecases/get_todo_by_id_usecase.dart';

abstract class IGetTodoByIdRepository {
  GetTodoByIdResponse getTodoById(int id);
}
