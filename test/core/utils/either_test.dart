import 'package:absence_manager/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Either left should only have a left value', () {
    const int number = 100;
    final Either<int> either = Either<int>.l(number);

    expect(either.isLeft, true);
    expect(either.isRight, false);

    int? handledLeftData;
    Failure? handledRightData;

    either.handle(
      (int l) => handledLeftData = l,
      (Failure r) => handledRightData = r,
    );

    expect(handledLeftData, number);
    expect(handledRightData, null);
  });

  test('Either right should only have a right value', () {
    const Failure failure = Failure();
    final Either<int> either = Either<int>.r(failure);

    expect(either.isLeft, false);
    expect(either.isRight, true);

    int? handledLeftData;
    Failure? handledRightData;

    either.handle(
      (int l) => handledLeftData = l,
      (Failure r) => handledRightData = r,
    );

    expect(handledLeftData, null);
    expect(handledRightData, failure);
  });
}
