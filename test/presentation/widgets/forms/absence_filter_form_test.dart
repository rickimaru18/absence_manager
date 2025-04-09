import 'package:absence_manager/domain/domain.dart';
import 'package:absence_manager/presentation/widgets/form_fields/absence_period_text_field.dart';
import 'package:absence_manager/presentation/widgets/form_fields/absence_type_dropdown_field.dart';
import 'package:absence_manager/presentation/widgets/forms/absence_filter_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../build_widget.dart';

void main() {
  Future<void> build(
    WidgetTester tester, {
    ValueChanged<AbsenceFilter?>? onFilter,
    AbsenceFilter? filter,
  }) =>
      buildWidget(
        tester,
        AbsenceFilterForm(
          onFilter: onFilter ?? (_) {},
          filter: filter,
        ),
      );

  group('[UI checks]', () {
    testWidgets('Initial display', (WidgetTester tester) async {
      await build(tester);

      expect(find.byType(AbsenceTypeDropdownField), findsOneWidget);
      expect(find.byType(AbsencePeriodTextField), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Filter'), findsOneWidget);
    });
  });

  group('[Event checks]', () {
    testWidgets(
      'Tapping filter button will trigger callback',
      (WidgetTester tester) async {
        bool isFilter = false;

        await build(
          tester,
          onFilter: (_) => isFilter = true,
        );
        await tester.tap(find.widgetWithText(TextButton, 'Filter'));

        expect(isFilter, true);
      },
    );
  });
}
