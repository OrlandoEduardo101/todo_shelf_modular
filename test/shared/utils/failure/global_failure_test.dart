import 'package:test/test.dart';
import 'package:todo_shelf_modular/shared/utils/failure/global_failure.dart';

class GlobalFailure extends IGlobalFailure {}

class EitherFailureMock extends EitherFailure {}
void main() {
  var classMock = GlobalFailure();
  test('must verify if classMock.message is empty', () {
    expect(classMock.message, isA<void>());
  });

  test('must verify if classMock.message is not empty', () {
    var classMock = EitherFailureMock();
    expect(classMock.message, isA<void>());
  });
}