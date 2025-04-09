import 'package:absence_manager/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../build_widget.dart';

void main() {
  const Failure failure = Failure();

  Future<void> build(
    WidgetTester tester, {
    VoidCallback? onTryAgain,
    String? errorMessage,
    String? tryAgainText,
  }) =>
      buildWidget(
        tester,
        TryAgainError(
          onTryAgain: onTryAgain ?? () {},
          error: failure,
          errorMessage: errorMessage,
          tryAgainText: tryAgainText,
        ),
      );

  group('[UI checks]', () {
    testWidgets('Initial display', (WidgetTester tester) async {
      await build(tester);

      expect(
        find.descendant(
          of: find.byType(Center),
          matching: find.text(failure.error),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Center),
          matching: find.widgetWithText(TextButton, 'Try again'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Can set custom error message', (WidgetTester tester) async {
      const String newErrorMessage = 'New error message';

      await build(
        tester,
        errorMessage: newErrorMessage,
      );

      expect(
        find.descendant(
          of: find.byType(Center),
          matching: find.text(failure.error),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(Center),
          matching: find.text(newErrorMessage),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Can set custom button text', (WidgetTester tester) async {
      const String newButtonText = 'Retry';

      await build(
        tester,
        tryAgainText: newButtonText,
      );

      expect(
        find.descendant(
          of: find.byType(Center),
          matching: find.widgetWithText(TextButton, 'Try again'),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(Center),
          matching: find.widgetWithText(TextButton, newButtonText),
        ),
        findsOneWidget,
      );
    });
  });

  group('[Event checks]', () {
    testWidgets(
      'Tapping try again button will trigger callback',
      (WidgetTester tester) async {
        bool isTryAgain = false;

        await build(
          tester,
          onTryAgain: () => isTryAgain = true,
        );

        expect(isTryAgain, false);

        await tester.tap(find.widgetWithText(TextButton, 'Try again'));

        expect(isTryAgain, true);
      },
    );
  });
}
