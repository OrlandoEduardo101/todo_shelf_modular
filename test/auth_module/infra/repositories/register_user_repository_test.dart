import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_register_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/auth_module/infra/datasources/i_register_user_datasource.dart';
import 'package:todo_shelf_modular/auth_module/infra/repositories/register_user_repository.dart';

class RegisterUserMock extends Mock implements IRegisterUserDatasource {}

main() {
  late RegisterUserRepository repository;
  late IRegisterUserDatasource datasource;
  final date = DateTime.now();

  setUpAll(() {
    datasource = RegisterUserMock();
    repository = RegisterUserRepository(datasource);
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

  test('must return UserEntity', () async {
    when(() => datasource.registerUser(any()))
        .thenAnswer((invocation) async => (response));

    var result = await repository.registerUser(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<UserEntity>());
  });

  test('must return IFailureLogin from daatsource', () async {
    when(() => datasource.registerUser(params))
        .thenThrow(RegisterCredentialsError());

    var result = await repository.registerUser(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<IFailureLogin>());
  });
}
