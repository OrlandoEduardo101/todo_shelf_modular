import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:todo_shelf_modular/shared/services/database_service.dart';
import 'package:todo_shelf_modular/todo_module/todo_module.dart';

import 'auth_module/auth_module.dart';
import 'shared/guards/auth_guard.dart';
import 'shared/services/jwt_service.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        // Bind.scoped((i) async => await DatabaseService.start().whenComplete(() => i<DatabaseService>().verifyTables(i()))),
        Bind.singleton<DatabaseService>((i) => DatabaseService()),
        Bind.scoped((i) => JwtService()),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.get('/', () => Response.ok('OK!')),
        Route.module('/auth', module: AuthModule()),
        Route.module('/todo', module: TodoModule(), middlewares: [AuthGuard(Modular.get<IJwtService>())]),
      ];
}

//C:\Users\Orlando Eduardo Pere\AppData\Roaming\Pub\Cache\bin