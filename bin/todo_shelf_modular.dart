import 'package:shelf_modular/shelf_modular.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:todo_shelf_modular/app_module.dart';
import 'package:todo_shelf_modular/shared/services/read_dot_env.dart';

Future<void> main(List<String> arguments) async {
  await ReadDotEnv().init();
  final env = ReadDotEnv().env;

  final server = await io.serve(Modular(module: AppModule()),
      '0.0.0.0', int.parse(env['API_PORT'] ?? '3001'));
  print('Server started: ${server.address.address}:${server.port}');
}
