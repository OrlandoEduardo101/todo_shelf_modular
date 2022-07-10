import 'package:todo_shelf_modular/auth_module/domain/entities/refresh_token_entity.dart';
import 'package:todo_shelf_modular/auth_module/domain/entities/user_entity.dart';
import 'package:todo_shelf_modular/shared/services/jwt_service.dart';

import '../../../shared/utils/either/custom_either.dart';
import '../errors/auth_error.dart';

abstract class IRefreshToken {
  Future<CustomEither<IFailureLogin, RefreshTokenEntity>> call(String token);
}

class RefreshToken implements IRefreshToken {
  final IJwtService _jwtService;
  RefreshToken(
    this._jwtService,
  );

  @override
  Future<CustomEither<IFailureLogin, RefreshTokenEntity>> call(
      String token) async {
    if (token.toLowerCase().startsWith('Bearer '.toLowerCase())) {
      token = token.split(' ').last.trim();
    }

    final isValidJwt = _jwtService.validateJwt(token);

    if (isValidJwt) {
      final userId = _jwtService.getUserId(token);
      final user = UserEntity(id: userId);
      final jwt = _jwtService.generateJWT(user);
      final refreshJwt =
          _jwtService.generateJWT(user, maxAge: const Duration(days: 15));
      return SuccessResponse(RefreshTokenEntity(
        refreshToken: refreshJwt,
        token: jwt,
      ));
    } else {
      return FailureResponse(RegisterCredentialsError(
        message: 'Refresh token is not valid',
        label: '403 - Not authorized',
      ));
    }
  }
}
