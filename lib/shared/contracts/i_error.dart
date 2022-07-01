abstract class IError implements Exception {
  final String message;
  final StackTrace stackTrace;

  const IError({
    required this.message,
    required this.stackTrace,
  });

  @override
  String toString() {
    return message;
  }
}
