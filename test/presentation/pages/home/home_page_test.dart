import 'package:absence_manager/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../build_widget.dart';

void main() {
  Future<void> build(WidgetTester tester) => buildWidget(
        tester,
        const HomePage(),
      );

  group('[UI checks]', () {
    testWidgets('Initial display', (WidgetTester tester) async {
      await build(tester);

      expect(find.widgetWithText(AppBar, 'Home Page'), findsOneWidget);
    });
  });

  // No event checks.
}
