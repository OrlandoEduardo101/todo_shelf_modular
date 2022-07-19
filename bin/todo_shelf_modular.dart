import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'dart:io';
import 'package:shelf/shelf.dart' as shelf;

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:todo_shelf_modular/app_module.dart';
import 'package:todo_shelf_modular/shared/services/read_dot_env.dart';

Future<void> main(List<String> arguments) async {
  await ReadDotEnv().init();
  final env = ReadDotEnv().env;

  const defaultHeadersList = [
    'accept',
    'accept-encoding',
    'authorization',
    'content-type',
    'dnt',
    'origin',
    'user-agent',
    'no_authorization',
    'refreshed_token',
  ];

  final overrideHeaders = {
    ACCESS_CONTROL_ALLOW_HEADERS: defaultHeadersList.join(','),
  };

  final server = await io.serve(
    Modular(module: AppModule(), middlewares: [
      logRequests(),
      corsHeaders(headers: overrideHeaders),
      jsonEncoder(),
    ]),
    '0.0.0.0',
    int.parse(env['API_PORT'] ?? '3001'),
  );

  // final server = await io.serve(
  //   (request) async {
  //     log('chamou $request');
  //     log(await request.readAsString());
  //     return Response.ok('fala zeze');
  //   },
  //   '0.0.0.0',
  //   int.parse(env['API_PORT'] ?? '3001'),
  // );

  print('Server started: ${server.address.address}:${server.port}');
}

shelf.Middleware jsonEncoder() {
  return (innerHanddler) {
    return (request) async {
      var response = await innerHanddler(request);

      if (!response.headers.containsKey(HttpHeaders.contentTypeHeader)) {
        response = response.change(headers: {
          ...response.headers,
          HttpHeaders.contentTypeHeader: 'application/json',
        });
      }

      return response;
    };
  };
}
