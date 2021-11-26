import 'dart:io';
import 'package:dotenv/dotenv.dart' as dotenv;

import 'package:postgres/postgres.dart';

import 'database_error.dart';

class DatabaseService {
  late PostgreSQLConnection _connection;

  static Future<DatabaseService> start() async {
    String filename = (await File.fromUri(Uri.parse('.env')).exists())
        ? '.env'
        : '.env.example';
    dotenv.load(filename);


    try {
      return await connect({
        'Database_HOST': dotenv.env['DB_HOST'],
        'Database_USER': dotenv.env['DB_USER'],
        'Database_PASS': dotenv.env['DB_PASS'],
        'Database_NAME': dotenv.env['DB_NAME'],
        'Database_PORT': dotenv.env['DB_PORT'],
      });
      
    } on PostgreSQLException catch (e) {
      throw ErrorToQuery(
          message: e.message,
          code: e.code,
          columnName: e.columnName,
          stackTrace: e.stackTrace,
          dataTypeName: e.dataTypeName);
    }

    // print('Serving at http://${server.address.host}:${server.port}');
  }

  static Future<DatabaseService> connect(Map<String, dynamic> env) async {
    int _port = env['Database_PORT'];
    String _host = env['Database_HOST'];
    String _user = env['Database_USER'];
    String _pass = env['Database_PASS'];
    String _name = env['Database_NAME'];

    DatabaseService database = DatabaseService();
    database._connection = PostgreSQLConnection(_host, _port, _name,
        username: _user, password: _pass);
    await database._connection.open();
    return database;
  }

  Future<List<dynamic>> query(String sql,
      {Map<String, dynamic> values = const {}}) async {
    try {
      return await _connection.mappedResultsQuery(sql,
          substitutionValues: values);
    } on PostgreSQLException catch (e) {
      throw ErrorToQuery(
          message: e.message,
          code: e.code,
          columnName: e.columnName,
          stackTrace: e.stackTrace,
          dataTypeName: e.dataTypeName);
    }
  }
}
