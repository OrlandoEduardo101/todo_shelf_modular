class TodoEntity {
  final int id;
  final int userId;
  final String name;
  final bool done;
  final DateTime? createAt;
  final DateTime? updateAt;
  final DateTime? deadlineAt;

  const TodoEntity({
    this.id = -1,
    this.userId = -1,
    this.name = '',
    this.done = false,
    this.updateAt,
    this.createAt,
    this.deadlineAt,
  });

  TodoEntity copyWith({
    int? id,
    int? userId,
    String? name,
    bool? done,
    DateTime? createAt,
    DateTime? updateAt,
    DateTime? deadlineAt,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      done: done ?? this.done,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      deadlineAt: deadlineAt ?? this.deadlineAt,
    );
  }
}
