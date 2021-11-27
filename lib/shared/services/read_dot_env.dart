import 'package:dotenv/dotenv.dart' as dotenv;
import 'dart:io';
import "package:path/path.dart" show dirname;
import 'dart:io' show Platform;

class ReadDotEnv {
  static final ReadDotEnv _singleton = ReadDotEnv._internal();

  factory ReadDotEnv() {
    return _singleton;
  }

  ReadDotEnv._internal() {
    init();
  }

  Map<String, String> _env = {};
  // ignore: unnecessary_getters_setters
  set env(Map<String, String> value) => _env = value;
  // ignore: unnecessary_getters_setters
  Map<String, String> get env => _env;

  // Map<String, String> get env {
  //   if (dotenv.env.isEmpty) {
  //     init();
  //   }
  //   return dotenv.env;
  // }

  Future<Map<String, String>> init() async {
    try {
      print(dirname(Platform.script.toString()));
      final uri = Uri();
      final path = Uri.parse('.env');
      String filename =
          (await File.fromUri(path).exists()) ? '.env' : '.env.example';
      dotenv.load(filename);
      env = dotenv.env;
      return dotenv.env;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
