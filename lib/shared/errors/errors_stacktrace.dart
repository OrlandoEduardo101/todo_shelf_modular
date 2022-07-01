import 'dart:developer';
import 'dart:io';

class ErrorsStacktrace {
  static void printError(
      {message, required StackTrace stackTrace, String? tag}) {
    if (!Platform.environment.containsKey('FLUTTER_TEST') && message != null) {
      final _tag = tag != null ? '[$tag!] ' : '';
      log('$_tag\\Error: $message', stackTrace: stackTrace);
    }
  }
}
