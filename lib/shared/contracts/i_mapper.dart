abstract class IMapper<T> {
  T fromMap(Map<String, dynamic> json);
  Map<String, dynamic> toMap(T object);
  void checkJson(Map<String, dynamic> json);
}
