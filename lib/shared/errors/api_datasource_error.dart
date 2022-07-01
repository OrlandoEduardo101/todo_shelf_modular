import 'error.dart';

class ApiDataSourceError extends DataSourceError {
  ApiDataSourceError({
    required String message,
    required StackTrace stackTrace,
  }) : super(message: message, stackTrace: stackTrace);
}
