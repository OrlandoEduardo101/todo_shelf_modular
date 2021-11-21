import 'dart:io';

abstract class IFailureLogin implements Exception {
  final String message;
  final StackTrace? stackTrace;
  final String label;
  final dynamic exception;

  @override
  String toString() => 'IFailureLogin(message: $message)';

  IFailureLogin({
    this.message = '',
    this.stackTrace,
    this.label = '',
    this.exception,
  }) {
    if (!(Platform.environment.containsKey('FLUTTER_TEST')) &&
        exception != null) {
      print('label: $label, stackTrace: $stackTrace');
    }
  }

}
