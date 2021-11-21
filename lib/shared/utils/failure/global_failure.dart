abstract class IGlobalFailure implements Exception {
  final String? message;
  IGlobalFailure({this.message});
}

abstract class EitherFailure implements Exception {
  final String? message;
  EitherFailure({this.message});
}