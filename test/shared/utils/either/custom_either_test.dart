
import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';
import 'package:test/test.dart';

void main() {
  test('must return SuccessResponse', () {
    var either = SuccessResponse('test');
    expect(either.fold((l) => l, (r) => r), equals('test'));
    expect(either | null, equals('test'));
    expect(either.isSuccess, true);
  });

  test('must return FailureResponse', () {
    var either = FailureResponse('FailureResponse');
    expect(either.fold((l) => l, (r) => r), equals('FailureResponse'));
    expect(either | null, null);
    expect(either.isFailure, true);
  });

  test('must return EitherFailure', () {
    var either = FailureResponse('FailureResponse');
    expect(either.isFailure, true);
  });
}
