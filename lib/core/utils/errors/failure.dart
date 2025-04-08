class Failure {
  const Failure([this._error]);

  factory Failure.fromException(Exception exception) =>
      Failure(exception.toString());

  String get error => _error ?? 'Something went wrong.';
  final String? _error;

  @override
  String toString() => error;
}
