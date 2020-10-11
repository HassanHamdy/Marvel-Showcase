class Result<T> {
  Result._();

  factory Result.success(T value, int statusCode) = SuccessState<T>;

  factory Result.error(T msg) = ErrorState<T>;
}

class ErrorState<T> extends Result<T> {
  ErrorState(this.msg) : super._();
  final T msg;
}

class SuccessState<T> extends Result<T> {
  SuccessState(this.value, this.statusCode) : super._();
  final T value;
  final int statusCode;
}
