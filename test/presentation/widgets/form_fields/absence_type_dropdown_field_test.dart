import 'package:absence_manager/core/core.dart';
import 'package:absence_manager/domain/domain.dart';
import 'package:absence_manager/presentation/widgets/form_fields/absence_type_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../build_widget.dart';

void main() {
  Future<void> build(
    WidgetTester tester, {
    ValueChanged<AbsenceType?>? onChanged,
    AbsenceType? value,
  }) =>
      buildWidget(
        tester,
        AbsenceTypeDropdownField(
          onChanged: onChanged ?? (_) {},
          value: value,
        ),
      );

  group('[UI checks]', () {
    testWidgets('Initial display', (WidgetTester tester) async {
      await build(tester);

      expect(
        find.widgetWithText(AppDropdownField<AbsenceType>, '-'),
        findsOneWidget,
      );

      for (final AbsenceType type in AbsenceType.values) {
        expect(
          find.widgetWithText(AppDropdownField<AbsenceType>, type.dropdownText),
          findsNothing,
        );
      }
    });

    testWidgets('Can set initial value', (WidgetTester tester) async {
      await build(
        tester,
        value: AbsenceType.sickness,
      );

      expect(
        find.widgetWithText(AppDropdownField<AbsenceType>, '-'),
        findsNothing,
      );

      for (final AbsenceType type in AbsenceType.values) {
        expect(
          find.widgetWithText(AppDropdownField<AbsenceType>, type.dropdownText),
          type == AbsenceType.sickness ? findsOneWidget : findsNothing,
        );
      }
    });
  });

  group('[Event checks]', () {
    testWidgets(
      'Tapping dropdown will show items',
      (WidgetTester tester) async {
        await build(tester);
        await tester.tap(find.byType(AppDropdownField<AbsenceType>));
        await tester.pumpAndSettle();

        expect(find.text('-'), findsNWidgets(2));

        for (final AbsenceType type in AbsenceType.values) {
          expect(find.text(type.dropdownText), findsOneWidget);
        }
      },
    );

    testWidgets(
      'Selecting new value should close dropdown',
      (WidgetTester tester) async {
        await build(tester);
        await tester.tap(find.byType(AppDropdownField<AbsenceType>));
        await tester.pumpAndSettle();
        await tester.tap(find.text(AbsenceType.sickness.dropdownText));
        await tester.pumpAndSettle();

        expect(
          find.widgetWithText(AppDropdownField<AbsenceType>, '-'),
          findsNothing,
        );

        for (final AbsenceType type in AbsenceType.values) {
          expect(
            find.widgetWithText(
              AppDropdownField<AbsenceType>,
              type.dropdownText,
            ),
            type == AbsenceType.sickness ? findsOneWidget : findsNothing,
          );
        }
      },
    );
  });
}
