
class UserEntity {
  final int id;

  final String name;

  final String email;

  final String token;

  UserEntity({this.id = -1, this.name = '', this.email = '', this.token = ''});
  

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? token,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }
}
