import 'error.dart';
import 'errors_stacktrace.dart';

class DataSourceError extends IError {
  DataSourceError({
    required String message,
    required StackTrace stackTrace,
  }) : super(message: message, stackTrace: stackTrace) {
    ErrorsStacktrace.printError(
      stackTrace: stackTrace,
      message: message,
      tag: 'DataSourceError',
    );
  }
}
