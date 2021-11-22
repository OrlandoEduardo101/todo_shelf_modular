import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_auth_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/auth_module/domain/repositories/i_authentication_user_repository.dart';
import 'package:todo_shelf_modular/auth_module/domain/usecases/authentication_user.dart';
import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';

class AuthenticationUserMock extends Mock
    implements IAuthenticationUserRepository {}

main() {
  late AuthenticationUser usecase;
  late IAuthenticationUserRepository repository;

  setUpAll(() {
    repository = AuthenticationUserMock();
    usecase = AuthenticationUser(repository);
    registerFallbackValue(UserAuthParams(email: 'teste@teste.com', password: '123456'));
  });

  final params = UserAuthParams(email: 'teste@teste.com', password: '123456');
  final paramsInvalidEmail = UserAuthParams(email: 'testeteste.com', password: '123456');
  final paramsInvalidPassword = UserAuthParams(email: 'teste@teste.com', password: '');
  final response = UserEntity(email: 'teste@teste.com');

  test('must return UserEntity', () async {
    when(() => repository.authenticationUser(any())).thenAnswer(
        (invocation) async => SuccessResponse<IFailureLogin, UserEntity>(response));

    var result = await usecase(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<UserEntity>());
  });

  test('must return IFailureLogin from email', () async {
    when(() => repository.authenticationUser(any())).thenAnswer(
        (invocation) async => SuccessResponse<IFailureLogin, UserEntity>(response));

    var result = await usecase(paramsInvalidEmail);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<LoginCredentialsError>());
    expect(
        result.fold(
          (l) => l.message,
          (r) => r,
        ),
        equals('Invalid email format'));
  });

  test('must return IFailureLogin from password', () async {
    when(() => repository.authenticationUser(any())).thenAnswer(
        (invocation) async => SuccessResponse<IFailureLogin, UserEntity>(response));

    var result = await usecase(paramsInvalidPassword);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<LoginCredentialsError>());
    expect(
        result.fold(
          (l) => l.message,
          (r) => r,
        ),
        equals('Invalid password format'));
  });

  test('must return IFailureLogin from repository', () async {
    when(() => repository.authenticationUser(any())).thenAnswer(
        (invocation) async => FailureResponse<IFailureLogin, UserEntity>(LoginCredentialsError()));

    var result = await usecase(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<IFailureLogin>());
  });
}
