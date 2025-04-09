import 'package:absence_manager/core/core.dart';
import 'package:absence_manager/domain/domain.dart';
import 'package:absence_manager/presentation/pages/home/home_page.dart';
import 'package:absence_manager/presentation/widgets/cards/absence_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../build_widget.dart';
import '../../../mocks.dart';

void main() {
  final List<Absence> absences = List<Absence>.generate(
    2,
    (int i) => Absence(
      id: i,
      member: Member(
        id: i,
        userId: i + 1,
        crewId: i + 2,
        name: 'Member $i',
      ),
      createdAt: DateTime.now(),
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 1)),
      type: i.isEven ? AbsenceType.sickness : AbsenceType.vacation,
    ),
  );

  late AbsencesUseCaseMock absencesUseCase;

  setUp(() {
    absencesUseCase = AbsencesUseCaseMock();

    when(() => absencesUseCase.getAllAbsences())
        .thenAnswer((_) async => Either<List<Absence>>.l(absences));
  });

  tearDown(() {
    verifyNoMoreInteractions(absencesUseCase);
  });

  Future<void> build(WidgetTester tester) => buildWidget(
        tester,
        BlocProvider<HomePageVm>(
          create: (_) => HomePageVm(absencesUseCase),
          child: const HomePage(),
        ),
      );

  group('[UI checks]', () {
    tearDown(() {
      verify(() => absencesUseCase.getAllAbsences()).called(1);
    });

    testWidgets(
      'Display absences when if not empty',
      (WidgetTester tester) async {
        await build(tester);
        await tester.pumpAndSettle();

        expect(find.byType(CenterLoader), findsNothing);
        expect(find.byType(TryAgainError), findsNothing);
        expect(find.byType(TryAgainEmpty), findsNothing);
        expect(
          find.descendant(
            of: find.byType(RefreshIndicator),
            matching: find.byType(ListView),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(ListView),
            matching: find.byType(AbsenceCard),
          ),
          findsNWidgets(absences.length),
        );
      },
    );

    testWidgets(
      'Display loader while fetching data',
      (WidgetTester tester) async {
        await build(tester);

        expect(find.byType(CenterLoader), findsOneWidget);
      },
    );

    testWidgets(
      'Display error when fetching data fails',
      (WidgetTester tester) async {
        const Failure error = Failure();

        when(() => absencesUseCase.getAllAbsences())
            .thenAnswer((_) async => Either<List<Absence>>.r(error));

        await build(tester);
        await tester.pumpAndSettle();

        expect(find.widgetWithText(TryAgainError, error.error), findsOneWidget);
      },
    );

    testWidgets(
      'Display empty when fetched data is empty',
      (WidgetTester tester) async {
        when(() => absencesUseCase.getAllAbsences())
            .thenAnswer((_) async => Either<List<Absence>>.l(<Absence>[]));

        await build(tester);
        await tester.pumpAndSettle();

        expect(find.byType(TryAgainEmpty), findsOneWidget);
      },
    );
  });

  group('[Event checks]', () {
    testWidgets(
      'Can pull-to-refresh absences list',
      (WidgetTester tester) async {
        await build(tester);
        await tester.pumpAndSettle();
        await tester.drag(find.byType(ListView), const Offset(0, 200));
        await tester.pumpAndSettle();

        expect(find.byType(AbsenceCard), findsNWidgets(absences.length));

        verify(() => absencesUseCase.getAllAbsences()).called(2);
      },
    );

    testWidgets(
      'Can retry when error is displayed',
      (WidgetTester tester) async {
        const Failure error = Failure();

        when(() => absencesUseCase.getAllAbsences())
            .thenAnswer((_) async => Either<List<Absence>>.r(error));

        await build(tester);
        await tester.pumpAndSettle();

        when(() => absencesUseCase.getAllAbsences())
            .thenAnswer((_) async => Either<List<Absence>>.l(absences));

        await tester.tap(find.widgetWithText(TextButton, 'Try again'));
        await tester.pumpAndSettle();

        expect(find.widgetWithText(TryAgainError, error.error), findsNothing);
        expect(find.byType(AbsenceCard), findsNWidgets(absences.length));

        verify(() => absencesUseCase.getAllAbsences()).called(2);
      },
    );

    testWidgets(
      'Can refresh when empty is displayed',
      (WidgetTester tester) async {
        when(() => absencesUseCase.getAllAbsences())
            .thenAnswer((_) async => Either<List<Absence>>.l(<Absence>[]));

        await build(tester);
        await tester.pumpAndSettle();

        when(() => absencesUseCase.getAllAbsences())
            .thenAnswer((_) async => Either<List<Absence>>.l(absences));

        await tester.tap(find.widgetWithText(TextButton, 'Refresh'));
        await tester.pumpAndSettle();

        expect(find.byType(TryAgainEmpty), findsNothing);
        expect(find.byType(AbsenceCard), findsNWidgets(absences.length));

        verify(() => absencesUseCase.getAllAbsences()).called(2);
      },
    );
  });
}
