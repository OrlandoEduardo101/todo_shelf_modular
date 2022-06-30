import 'package:postgres/postgres.dart';
import 'database_error.dart';
import 'read_dot_env.dart';

class DatabaseService {
  late PostgreSQLConnection _connection;

  static final DatabaseService _singleton = DatabaseService._internal();

  factory DatabaseService() {
    start().then((value) => value.verifyTables());
    return _singleton;
  }

  DatabaseService._internal();

  static Future<DatabaseService> start() async {
    // String filename = (await File.fromUri(Uri.parse('.env')).exists())
    //     ? '.env'
    //     : '.env.example';
    // dotenv.load(filename);

    try {
      final env = await ReadDotEnv().init();
      return await connect({
        'Database_HOST': env['DB_HOST'],
        'Database_USER': env['DB_USER'],
        'Database_PASS': env['DB_PASS'],
        'Database_NAME': env['DB_NAME'],
        'Database_PORT': env['DB_PORT'],
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

  Future<void> verifyTables() async {
    // username VARCHAR ( 50 ) UNIQUE NOT NULL,
    var result = await execute('''
              CREATE TABLE IF NOT EXISTS users (
                id serial PRIMARY KEY,
                passwordHash VARCHAR ( 255 ) NOT NULL,
                name VARCHAR ( 255 ) NOT NULL,
                email VARCHAR ( 255 ) UNIQUE NOT NULL,
                created_on TIMESTAMP NOT NULL,
                last_login TIMESTAMP 
              );''');

            if (result == 0) {
              print('no has table');
            }
  }

  static Future<DatabaseService> connect(Map<String, dynamic> env) async {
    int _port = int.tryParse(env['Database_PORT']) ?? 9001;
    String _host = env['Database_HOST'];
    String _user = env['Database_USER'];
    String _pass = env['Database_PASS'];
    String _name = env['Database_NAME'];

    // DatabaseService database = DatabaseService();
    _singleton._connection = PostgreSQLConnection(_host, _port, _name,
        username: _user, password: _pass);
    await _singleton._connection.open();
    return _singleton;
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

  Future<int> execute(String sql,
      {Map<String, dynamic> values = const {}}) async {
    try {
      return await _connection.execute(sql);
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
