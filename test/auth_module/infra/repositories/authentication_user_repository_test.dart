import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_auth_params.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/errors/auth_error.dart';
import 'package:todo_shelf_modular/auth_module/infra/datasources/i_authentication_user_datasource.dart';
import 'package:todo_shelf_modular/auth_module/infra/repositories/authentication_user_repository.dart';

class AuthenticationUserMock extends Mock
    implements IAuthenticationUserDatasource {}

main() {
  late AuthenticationUserRepository repository;
  late IAuthenticationUserDatasource datasource;
  final date = DateTime.now();

  setUpAll(() {
    datasource = AuthenticationUserMock();
    repository = AuthenticationUserRepository(datasource);
    registerFallbackValue(UserAuthParams(
      email: 'teste@teste.com',
      password: '123456',
      lastLogin: date,
    ));
  });

  final params = UserAuthParams(
    email: 'teste@teste.com',
    password: '123456',
    lastLogin: date,
  );
  final response = UserEntity(email: 'teste@teste.com');

  test('must return UserEntity', () async {
    when(() => datasource.authenticationUser(any()))
        .thenAnswer((invocation) async => (response));

    var result = await repository.authenticationUser(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<UserEntity>());
  });

  test('must return IFailureLogin from daatsource', () async {
    when(() => datasource.authenticationUser(params))
        .thenThrow(LoginCredentialsError());

    var result = await repository.authenticationUser(params);

    expect(
        result.fold(
          (l) => l,
          (r) => r,
        ),
        isA<IFailureLogin>());
  });
}
