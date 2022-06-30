import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_register_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/auth_module/domain/repositories/i_register_user_repository.dart';
import 'package:todo_shelf_modular/auth_module/domain/usecases/register_user.dart';
import 'package:todo_shelf_modular/shared/utils/either/custom_either.dart';

class RegisterUserMock extends Mock implements IRegisterUserRepository {}

main() {
  late RegisterUser usecase;
  late IRegisterUserRepository repository;
  final date = DateTime.now();

  setUpAll(() {
    repository = RegisterUserMock();
    usecase = RegisterUser(repository);
    registerFallbackValue(UserRegisterParams(
      email: 'teste@teste.com',
      password: '123456',
      name: 'teste',
      createdOn: date,
      lastLogin: date,
    ));
  });

  final response = UserEntity(email: 'teste@teste.com');
  final params = UserRegisterParams(
    email: 'teste@teste.com',
    password: '123456',
    name: 'teste',
    createdOn: date,
    lastLogin: date,
  );
  final paramsInvalidName = UserRegisterParams(
    email: 'teste@teste.com',
    password: '123456',
    name: '',
    createdOn: date,
    lastLogin: date,
  );
  final paramsInvalidEmail = UserRegisterParams(
    email: 'testeteste.com',
    password: '123456',
    name: 'teste',
    createdOn: date,
    lastLogin: date,
  );
  final paramsInvalidPassword = UserRegisterParams(
    email: 'teste@teste.com',
    password: '',
    name: 'teste',
    createdOn: date,
    lastLogin: date,
  );

  test('must return UserEntity', () async {
    when(() => repository.registerUser(any())).thenAnswer((invocation) async =>
        SuccessResponse<IFailureLogin, UserEntity>(response));

    var result = await usecase(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<UserEntity>());
  });

  test('must return IFailureLogin from email', () async {
    when(() => repository.registerUser(any())).thenAnswer((invocation) async =>
        SuccessResponse<IFailureLogin, UserEntity>(response));

    var result = await usecase(paramsInvalidEmail);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<RegisterCredentialsError>());
    expect(
        result.fold(
          (l) => l.message,
          (r) => r,
        ),
        equals('Invalid email format'));
  });

  test('must return IFailureLogin from password', () async {
    when(() => repository.registerUser(any())).thenAnswer((invocation) async =>
        SuccessResponse<IFailureLogin, UserEntity>(response));

    var result = await usecase(paramsInvalidPassword);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<RegisterCredentialsError>());
    expect(
        result.fold(
          (l) => l.message,
          (r) => r,
        ),
        equals('Invalid password format'));
  });

  test('must return IFailureLogin from name', () async {
    when(() => repository.registerUser(any())).thenAnswer((invocation) async =>
        SuccessResponse<IFailureLogin, UserEntity>(response));

    var result = await usecase(paramsInvalidName);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<RegisterCredentialsError>());
    expect(
        result.fold(
          (l) => l.message,
          (r) => r,
        ),
        equals('Invalid name format'));
  });

  test('must return IFailureLogin from repository', () async {
    when(() => repository.registerUser(any())).thenAnswer((invocation) async =>
        FailureResponse<IFailureLogin, UserEntity>(RegisterCredentialsError()));

    var result = await usecase(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<IFailureLogin>());
  });
}
