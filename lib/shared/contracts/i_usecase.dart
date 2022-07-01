import '../errors/domain_error.dart';
import 'contracts.dart';
import 'i_value_object.dart';

abstract class Usecase {
  DomainError getError(IValueObject value) {
    return DomainError(
        message: value.hasError()!, stackTrace: StackTrace.current);
  }

  bool hasError(IValueObject value) => !(value.isValid);
}
