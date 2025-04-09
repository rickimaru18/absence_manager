import 'package:absence_manager/core/core.dart';
import 'package:absence_manager/domain/domain.dart';
import 'package:absence_manager/presentation/widgets/avatars/member_avatar.dart';
import 'package:absence_manager/presentation/widgets/cards/absence_card.dart';
import 'package:absence_manager/presentation/widgets/chips/absence_status_chip.dart';
import 'package:absence_manager/presentation/widgets/chips/absence_type_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../build_widget.dart';

void main() {
  const Member member = Member(
    id: 1,
    userId: 1,
    crewId: 1,
    name: 'Member',
  );
  final Absence absence = Absence(
    id: 1,
    member: member,
    createdAt: DateTime.now(),
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 1)),
    type: AbsenceType.vacation,
    memberNote: 'Member note',
    admitterNote: 'Admitter note',
  );

  Future<void> build(
    WidgetTester tester, {
    Absence? customAbsence,
  }) =>
      buildWidget(
        tester,
        AbsenceCard(
          absence: customAbsence ?? absence,
        ),
      );

  group('[UI checks]', () {
    testWidgets('Displaying all components', (WidgetTester tester) async {
      await build(tester);

      final Finder cardFinder = find.byType(Card);

      // Header
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.byType(MemberAvatar),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.text(absence.member.name),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.text(
            '${absence.startDate.yMEd()} ~ ${absence.endDate.yMEd()}',
          ),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.byType(AbsenceTypeChip),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.byType(AbsenceStatusChip),
        ),
        findsOneWidget,
      );

      // Footer
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.text('Note :'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.text(absence.memberNote),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.text('Admitter Note :'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.text(absence.admitterNote),
        ),
        findsOneWidget,
      );
    });

    testWidgets(
      'Empty member note will not display component',
      (WidgetTester tester) async {
        final Absence noMemberNoteAbsence = Absence(
          id: 1,
          member: member,
          createdAt: DateTime.now(),
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 1)),
          type: AbsenceType.vacation,
          admitterNote: 'Admitter note',
        );

        await build(
          tester,
          customAbsence: noMemberNoteAbsence,
        );

        expect(find.text('Note :'), findsNothing);
        expect(find.text(noMemberNoteAbsence.memberNote), findsNothing);
      },
    );

    testWidgets(
      'Empty admitter note will not display component',
      (WidgetTester tester) async {
        final Absence noAdmitterNoteAbsence = Absence(
          id: 1,
          member: member,
          createdAt: DateTime.now(),
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 1)),
          type: AbsenceType.vacation,
          memberNote: 'Member note',
        );

        await build(
          tester,
          customAbsence: noAdmitterNoteAbsence,
        );

        expect(find.text('Admitter Note :'), findsNothing);
        expect(find.text(noAdmitterNoteAbsence.admitterNote), findsNothing);
      },
    );
  });

  // No event checks.
}
