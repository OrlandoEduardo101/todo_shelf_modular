import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:todo_shelf_modular/auth_module/auth_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        Route.module('/auth', module: AuthModule()),
      ];
}

//C:\Users\Orlando Eduardo Pere\AppData\Roaming\Pub\Cache\bin