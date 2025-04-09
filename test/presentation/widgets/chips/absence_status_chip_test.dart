import 'package:absence_manager/domain/domain.dart';
import 'package:absence_manager/presentation/widgets/chips/absence_status_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../build_widget.dart';

void main() {
  Future<void> build(
    WidgetTester tester, {
    AbsenceStatus status = AbsenceStatus.requested,
  }) =>
      buildWidget(
        tester,
        AbsenceStatusChip(
          status: status,
        ),
      );

  group('[UI checks]', () {
    testWidgets(
      '"requested" status have a different color and text',
      (WidgetTester tester) async {
        await build(tester);

        final Finder chipFinder =
            find.widgetWithText(Chip, AbsenceStatus.requested.name);

        expect(
          tester.widget<Chip>(chipFinder).backgroundColor,
          Colors.lightBlue,
        );
        expect(chipFinder, findsOneWidget);
      },
    );

    testWidgets(
      '"confirmed" status have a different color and text',
      (WidgetTester tester) async {
        await build(
          tester,
          status: AbsenceStatus.confirmed,
        );

        final Finder chipFinder =
            find.widgetWithText(Chip, AbsenceStatus.confirmed.name);

        expect(
          tester.widget<Chip>(chipFinder).backgroundColor,
          Colors.lightGreen,
        );
        expect(chipFinder, findsOneWidget);
      },
    );

    testWidgets(
      '"rejected" status have a different color and text',
      (WidgetTester tester) async {
        await build(
          tester,
          status: AbsenceStatus.rejected,
        );

        final Finder chipFinder =
            find.widgetWithText(Chip, AbsenceStatus.rejected.name);

        expect(tester.widget<Chip>(chipFinder).backgroundColor, Colors.red);
        expect(chipFinder, findsOneWidget);
      },
    );
  });

  // No event checks.
}
