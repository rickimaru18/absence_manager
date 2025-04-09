import 'package:absence_manager/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../build_widget.dart';

void main() {
  Future<void> build(WidgetTester tester) => buildWidget(
        tester,
        const CenterLoader(),
      );

  group('[UI checks]', () {
    testWidgets('Initial display', (WidgetTester tester) async {
      await build(tester);

      expect(
        find.descendant(
          of: find.byType(Center),
          matching: find.byType(CircularProgressIndicator),
        ),
        findsOneWidget,
      );
    });
  });

  // No event checks.
}
