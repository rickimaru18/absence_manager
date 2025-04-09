import 'package:flutter/foundation.dart';

import '../core.dart';

typedef EitherHandler<S> = void Function(S data);

class Either<T> {
  Either._(this._l, this._r);

  factory Either.l(T left) => Either<T>._(left, null);

  factory Either.r(Failure right) => Either<T>._(null, right);

  @visibleForTesting
  T? get l => _l;
  T? _l;

  @visibleForTesting
  Failure? get r => _r;
  Failure? _r;

  bool get isLeft => _l != null;

  bool get isRight => _r != null;

  void handle(EitherHandler<T> l, EitherHandler<Failure> r) =>
      isLeft ? l(_l as T) : r(_r!);
}
