import 'error.dart';

class DomainError extends IError {
  DomainError({required message, required StackTrace stackTrace})
      : super(message: message, stackTrace: stackTrace);

  @override
  String toString() => 'DomainError(message: $message)';
}
