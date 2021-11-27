import 'package:postgres/postgres.dart';
import 'database_error.dart';
import 'read_dot_env.dart';

class DatabaseService {
  late PostgreSQLConnection _connection;

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

  Future<void> verifyTables(DatabaseService value) async {
    var result = await query('''SELECT EXISTS (
    SELECT FROM information_schema.tables 
    WHERE  table_name  = 'users'
    );''');
    
    if (!((result.first as Map).entries.first.value["exists"])) {
      print('no has table');
    }
  }

  static Future<DatabaseService> connect(Map<String, dynamic> env) async {
    int _port = int.tryParse(env['Database_PORT']) ?? 9001;
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
