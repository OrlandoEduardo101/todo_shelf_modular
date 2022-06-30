import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:todo_shelf_modular/shared/services/database_service.dart';

import 'auth_module/auth_module.dart';

class AppModule extends Module {

  @override
  List<Bind> get binds => [
    // Bind.scoped((i) async => await DatabaseService.start().whenComplete(() => i<DatabaseService>().verifyTables(i()))),
    Bind.singleton<DatabaseService>((i) => DatabaseService()),
  ];

  @override
  List<ModularRoute> get routes => [
        Route.get('/', () => Response.ok('OK!')),
        Route.module('/auth', module: AuthModule()),
      ];
}

//C:\Users\Orlando Eduardo Pere\AppData\Roaming\Pub\Cache\bin