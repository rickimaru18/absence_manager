import 'package:absence_manager/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../build_widget.dart';

void main() {
  Future<void> build(
    WidgetTester tester, {
    VoidCallback? onRefresh,
    String? message,
    String? refreshText,
  }) =>
      buildWidget(
        tester,
        TryAgainEmpty(
          onRefresh: onRefresh ?? () {},
          message: message,
          refreshText: refreshText,
        ),
      );

  group('[UI checks]', () {
    testWidgets('Initial display', (WidgetTester tester) async {
      await build(tester);

      expect(
        find.descendant(
          of: find.byType(TryAgainError),
          matching: find.text('Empty'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(TryAgainError),
          matching: find.widgetWithText(TextButton, 'Refresh'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Can set custom empty message', (WidgetTester tester) async {
      const String newErrorMessage = 'New empty message';

      await build(
        tester,
        message: newErrorMessage,
      );

      expect(
        find.descendant(
          of: find.byType(TryAgainError),
          matching: find.text('Empty'),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(TryAgainError),
          matching: find.text(newErrorMessage),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Can set custom button text', (WidgetTester tester) async {
      const String newButtonText = 'Retry';

      await build(
        tester,
        refreshText: newButtonText,
      );

      expect(
        find.descendant(
          of: find.byType(TryAgainError),
          matching: find.widgetWithText(TextButton, 'Refresh'),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(TryAgainError),
          matching: find.widgetWithText(TextButton, newButtonText),
        ),
        findsOneWidget,
      );
    });
  });

  group('[Event checks]', () {
    testWidgets(
      'Tapping refresh button will trigger callback',
      (WidgetTester tester) async {
        bool isRefresh = false;

        await build(
          tester,
          onRefresh: () => isRefresh = true,
        );

        expect(isRefresh, false);

        await tester.tap(find.widgetWithText(TextButton, 'Refresh'));

        expect(isRefresh, true);
      },
    );
  });
}
