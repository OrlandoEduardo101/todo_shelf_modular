import 'dart:developer';

import '../../../shared/services/database_error.dart';
import '../../../shared/services/database_service.dart';
import '../../domain/errors/todo_error.dart';
import '../../infra/datasources/i_delete_todo_datasource.dart';

class DeleteTodoDatasource implements IDeleteTodoDatasource {
  final DatabaseService _database;

  DeleteTodoDatasource(this._database);
  @override
  Future<bool> deleteTodo(int id) async {
    try {
      String sql = '''
          DELETE FROM
            todos
          WHERE
            id = @id;''';

      final result =
          await _database.query(sql, values: {'id': id});
      log(result.toString());
      return true;
    } on IDatabaseError catch (e, s) {
      throw SaveTodoDatabaseError(
          message: e.message ?? '', exception: e, stackTrace: s);
    } catch (e) {
      rethrow;
    }
  }
}
