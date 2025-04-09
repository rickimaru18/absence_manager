import 'package:absence_manager/domain/domain.dart';
import 'package:absence_manager/presentation/widgets/chips/absence_type_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../build_widget.dart';

void main() {
  Future<void> build(
    WidgetTester tester, {
    AbsenceType type = AbsenceType.vacation,
  }) =>
      buildWidget(
        tester,
        AbsenceTypeChip(
          type: type,
        ),
      );

  group('[UI checks]', () {
    testWidgets(
      '"vacation" type have a different icon and text',
      (WidgetTester tester) async {
        await build(tester);

        expect(
          find.widgetWithIcon(Chip, Icons.flight_takeoff_rounded),
          findsOneWidget,
        );
        expect(
          find.widgetWithText(Chip, AbsenceType.vacation.name),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      '"sickness" type have a different icon and text',
      (WidgetTester tester) async {
        await build(
          tester,
          type: AbsenceType.sickness,
        );

        expect(
          find.widgetWithIcon(Chip, Icons.local_hospital_rounded),
          findsOneWidget,
        );
        expect(
          find.widgetWithText(Chip, AbsenceType.sickness.name),
          findsOneWidget,
        );
      },
    );
  });

  // No event checks.
}
