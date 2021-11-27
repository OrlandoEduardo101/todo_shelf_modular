import 'package:test/test.dart';
import 'package:todo_shelf_modular/shared/services/database_service.dart';

void main() {
  test('test database init', () async {
    var database = await DatabaseService.start();
    var value = await database.verifyTables(database);
  });
}
