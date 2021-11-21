import '../failure/global_failure.dart';

abstract class CustomEither<TFailure, TSuccess> {
  final TFailure? _failure;
  final TSuccess? _success;
  CustomEither({TFailure? failure, TSuccess? success})
      : _failure = failure,
        _success = success,
        assert(success != null || failure != null)
        //assert(failure == null && success != null)
        ;

  T fold<T>(T Function(TFailure)? onFailure, T Function(TSuccess)? onSuccess) {
    if (_failure != null && onFailure != null) return onFailure(_failure!);
    if (_success != null && onSuccess != null) return onSuccess(_success!);
    throw ResponseNotDefinedFailure();
  }

  static SuccessResponse<TFailure, TSuccess> success<TFailure, TSuccess>(
          TSuccess value) =>
      SuccessResponse<TFailure, TSuccess>(value);

  static FailureResponse<TFailure, TSuccess> failure<TFailure, TSuccess>(
          TFailure value) =>
      FailureResponse<TFailure, TSuccess>(value);

  bool get isSuccess => _success != null;
  bool get isFailure => _failure != null;

  // ignore: unnecessary_this
  TSuccess? operator |(TSuccess? newFailureResponse) => this
      .fold((_) => newFailureResponse, (value) => value);
}

class SuccessResponse<TFailure, TSuccess>
    extends CustomEither<TFailure, TSuccess> {
  SuccessResponse(TSuccess value) : super(success: value);
}

class FailureResponse<TFailure, TSuccess>
    extends CustomEither<TFailure, TSuccess> {
  FailureResponse(TFailure value) : super(failure: value);
}

class ResponseNotDefinedFailure extends EitherFailure {
  ResponseNotDefinedFailure()
      : super(message: 'Invalid Response. Failure or Success not defined');
}
