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

class LoginCredentialsError implements IFailureLogin {
  
  @override
  final String message;
  @override
  final StackTrace? stackTrace;
  @override
  final String label;
  @override
  final dynamic exception;

  @override
  String toString() => 'IFailureLogin(message: $message)';

  LoginCredentialsError({
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

class RegisterCredentialsError implements IFailureLogin {
  
  @override
  final String message;
  @override
  final StackTrace? stackTrace;
  @override
  final String label;
  @override
  final dynamic exception;

  @override
  String toString() => 'IFailureLogin(message: $message)';

  RegisterCredentialsError({
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

class SaveDatabaseError implements IFailureLogin {
  
  @override
  final String message;
  @override
  final StackTrace? stackTrace;
  @override
  final String label;
  @override
  final dynamic exception;

  @override
  String toString() => 'IFailureLogin(message: $message)';

  SaveDatabaseError({
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