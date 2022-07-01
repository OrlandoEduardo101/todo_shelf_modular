import 'dart:io';

abstract class IFailureTodo implements Exception {
  final String message;
  final StackTrace? stackTrace;
  final String label;
  final dynamic exception;

  @override
  String toString() => 'IFailureTodo(message: $message)';

  IFailureTodo({
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

class TodoCredentialsError implements IFailureTodo {
  
  @override
  final String message;
  @override
  final StackTrace? stackTrace;
  @override
  final String label;
  @override
  final dynamic exception;

  @override
  String toString() => 'IFailureTodo(message: $message)';

  TodoCredentialsError({
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

class SaveTodoDatabaseError implements IFailureTodo {
  
  @override
  final String message;
  @override
  final StackTrace? stackTrace;
  @override
  final String label;
  @override
  final dynamic exception;

  @override
  String toString() => 'IFailureTodo(message: $message)';

  SaveTodoDatabaseError({
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

class ReadTodoDatabaseError implements IFailureTodo {
  
  @override
  final String message;
  @override
  final StackTrace? stackTrace;
  @override
  final String label;
  @override
  final dynamic exception;

  @override
  String toString() => 'IFailureTodo(message: $message)';

  ReadTodoDatabaseError({
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

class MapperTodoDatabaseError implements IFailureTodo {
  
  @override
  final String message;
  @override
  final StackTrace? stackTrace;
  @override
  final String label;
  @override
  final dynamic exception;

  @override
  String toString() => 'IFailureTodo(message: $message)';

  MapperTodoDatabaseError({
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