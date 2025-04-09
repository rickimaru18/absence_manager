import 'package:absence_manager/core/core.dart';
import 'package:absence_manager/domain/domain.dart';
import 'package:absence_manager/presentation/pages/home/home_page.dart';
import 'package:absence_manager/presentation/widgets/cards/absence_card.dart';
import 'package:absence_manager/presentation/widgets/forms/absence_filter_form.dart';
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

    when(
      () => absencesUseCase.getAllAbsences(
        filter: any(named: 'filter'),
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer((_) async => Either<List<Absence>>.l(absences));
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
      verify(
        () => absencesUseCase.getAllAbsences(
          offset: 0,
          limit: 10,
        ),
      ).called(1);
    });

    testWidgets(
      'Display absences when if not empty',
      (WidgetTester tester) async {
        await build(tester);
        await tester.pumpAndSettle();

        expect(find.widgetWithText(ExpansionTile, 'Filter'), findsOneWidget);
        expect(find.byType(AbsenceFilterForm), findsNothing);
        expect(find.byType(CenterLoader), findsNothing);
        expect(find.byType(TryAgainError), findsNothing);
        expect(find.byType(TryAgainEmpty), findsNothing);
        expect(find.byType(PaginatedListView), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(PaginatedListView),
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

        expect(find.widgetWithText(ExpansionTile, 'Filter'), findsOneWidget);
        expect(find.byType(AbsenceFilterForm), findsNothing);
        expect(find.byType(CenterLoader), findsOneWidget);
      },
    );

    testWidgets(
      'Display error when fetching data fails',
      (WidgetTester tester) async {
        const Failure error = Failure();

        when(
          () => absencesUseCase.getAllAbsences(
            filter: any(named: 'filter'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => Either<List<Absence>>.r(error));

        await build(tester);
        await tester.pumpAndSettle();

        expect(find.widgetWithText(ExpansionTile, 'Filter'), findsOneWidget);
        expect(find.byType(AbsenceFilterForm), findsNothing);
        expect(find.widgetWithText(TryAgainError, error.error), findsOneWidget);
      },
    );

    testWidgets(
      'Display empty when fetched data is empty',
      (WidgetTester tester) async {
        when(
          () => absencesUseCase.getAllAbsences(
            filter: any(named: 'filter'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => Either<List<Absence>>.l(<Absence>[]));

        await build(tester);
        await tester.pumpAndSettle();

        expect(find.widgetWithText(ExpansionTile, 'Filter'), findsOneWidget);
        expect(find.byType(AbsenceFilterForm), findsNothing);
        expect(find.byType(TryAgainEmpty), findsOneWidget);
      },
    );
  });

  group('[Event checks]', () {
    testWidgets(
      'Can expand filter section',
      (WidgetTester tester) async {
        await build(tester);
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(ExpansionTile, 'Filter'));
        await tester.pumpAndSettle();

        expect(find.byType(AbsenceFilterForm), findsOneWidget);

        verify(
          () => absencesUseCase.getAllAbsences(
            offset: 0,
            limit: 10,
          ),
        ).called(1);
      },
    );

    testWidgets(
      'Tapping filter will fetch filtered data',
      (WidgetTester tester) async {
        await build(tester);
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(ExpansionTile, 'Filter'));
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(TextButton, 'Filter'));
        await tester.pumpAndSettle();

        expect(find.byType(AbsenceFilterForm), findsOneWidget);

        verify(
          () => absencesUseCase.getAllAbsences(
            offset: 0,
            limit: 10,
          ),
        ).called(1);
        verify(
          () => absencesUseCase.getAllAbsences(
            filter: AbsenceFilter(),
            offset: 0,
            limit: 10,
          ),
        ).called(1);
      },
    );

    // TODO(Rick): Why "refresh" is not called.
    // testWidgets(
    //   'Can pull-to-refresh absences list',
    //   (WidgetTester tester) async {
    //     await build(tester);
    //     await tester.pumpAndSettle();
    //     await tester.drag(find.byType(PaginatedListView), const Offset(0, 200));
    //     await tester.pumpAndSettle();

    //     expect(find.byType(AbsenceCard), findsNWidgets(absences.length));

    //     verify(
    //       () => absencesUseCase.getAllAbsences(
    //         offset: 0,
    //         limit: 10,
    //       ),
    //     ).called(2);
    //   },
    // );

    testWidgets('Can paginate absences list', (WidgetTester tester) async {
      final List<Absence> longAbsences = List<Absence>.generate(
        10,
        (int i) => Absence(
          id: i + 10,
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

      when(
        () => absencesUseCase.getAllAbsences(
          filter: any(named: 'filter'),
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => Either<List<Absence>>.l(longAbsences));

      await build(tester);

      for (int i = 0; i < 50; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }

      when(
        () => absencesUseCase.getAllAbsences(
          filter: any(named: 'filter'),
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => Either<List<Absence>>.l(absences));

      await tester.drag(find.byType(PaginatedListView), const Offset(0, -1000));
      await tester.pumpAndSettle();

      verify(
        () => absencesUseCase.getAllAbsences(
          offset: 0,
          limit: 10,
        ),
      ).called(1);
      verify(
        () => absencesUseCase.getAllAbsences(
          offset: 10,
          limit: 10,
        ),
      ).called(1);
    });

    testWidgets(
      'Can retry when error is displayed',
      (WidgetTester tester) async {
        const Failure error = Failure();

        when(
          () => absencesUseCase.getAllAbsences(
            filter: any(named: 'filter'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => Either<List<Absence>>.r(error));

        await build(tester);
        await tester.pumpAndSettle();

        when(
          () => absencesUseCase.getAllAbsences(
            filter: any(named: 'filter'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => Either<List<Absence>>.l(absences));

        await tester.tap(find.widgetWithText(TextButton, 'Try again'));
        await tester.pumpAndSettle();

        expect(find.widgetWithText(TryAgainError, error.error), findsNothing);
        expect(find.byType(AbsenceCard), findsNWidgets(absences.length));

        verify(
          () => absencesUseCase.getAllAbsences(
            offset: 0,
            limit: 10,
          ),
        ).called(2);
      },
    );

    testWidgets(
      'Can refresh when empty is displayed',
      (WidgetTester tester) async {
        when(
          () => absencesUseCase.getAllAbsences(
            filter: any(named: 'filter'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => Either<List<Absence>>.l(<Absence>[]));

        await build(tester);
        await tester.pumpAndSettle();

        when(
          () => absencesUseCase.getAllAbsences(
            filter: any(named: 'filter'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => Either<List<Absence>>.l(absences));

        await tester.tap(find.widgetWithText(TextButton, 'Refresh'));
        await tester.pumpAndSettle();

        expect(find.byType(TryAgainEmpty), findsNothing);
        expect(find.byType(AbsenceCard), findsNWidgets(absences.length));

        verify(
          () => absencesUseCase.getAllAbsences(
            offset: 0,
            limit: 10,
          ),
        ).called(2);
      },
    );
  });
}
