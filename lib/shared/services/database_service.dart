import 'package:postgres/postgres.dart';

import 'database_error.dart';

class DatabaseService {

  late PostgreSQLConnection _connection;

  static Future<DatabaseService> connect(Map<String, dynamic> env) async {

    int _port = 5432;
    String _host = env['Database_HOST'];
    String _user = env['Database_USER'];
    String _pass = env['Database_PASS'];
    String _name = env['Database_NAME'];

    DatabaseService database = DatabaseService();
    database._connection = PostgreSQLConnection(_host, _port, _name, username: _user, password: _pass);
    await database._connection.open();
    return database;
  }

  Future<List<dynamic>> query(String sql, { Map<String, dynamic> values = const {}}) async {

    try { 
      return await _connection.mappedResultsQuery(sql, substitutionValues: values); 
    } on PostgreSQLException
    catch(e) {
      throw ErrorToQuery(message: e.message, code: e.code, columnName: e.columnName, stackTrace:  e.stackTrace, dataTypeName: e.dataTypeName); 
    }
  }
}