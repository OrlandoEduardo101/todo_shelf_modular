import 'package:shelf_modular/shelf_modular.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:todo_shelf_modular/app_module.dart';

Future<void> main(List<String> arguments) async {
  final server = await io.serve(Modular(module: AppModule()), '127.0.0.1', 3001);
    print('Server started: ${server.address.address}:${server.port}');

}
