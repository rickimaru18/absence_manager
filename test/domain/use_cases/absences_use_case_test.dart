import 'package:absence_manager/core/core.dart';
import 'package:absence_manager/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late AbsencesUseCase useCase;
  late AbsencesRepositoryMock absencesRepository;

  setUp(() {
    absencesRepository = AbsencesRepositoryMock();
    useCase = AbsencesUseCase(absencesRepository);
  });

  group('[getAllAbsences] tests', () {
    final AbsenceFilter filter = AbsenceFilter(
      type: AbsenceType.vacation,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 1)),
    );

    tearDown(() {
      verify(
        () => absencesRepository.getAbsences(
          filter: filter,
        ),
      ).called(1);
      verifyNoMoreInteractions(absencesRepository);
    });

    test('Successful', () async {
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

      when(
        () => absencesRepository.getAbsences(
          filter: any(
            named: 'filter',
          ),
        ),
      ).thenAnswer((_) async => Either<List<Absence>>.l(absences));

      final Either<List<Absence>> result = await useCase.getAllAbsences(
        filter: filter,
      );

      expect(result.l, absences);
    });

    test('Failure', () async {
      const Failure failure = Failure();

      when(
        () => absencesRepository.getAbsences(
          filter: any(
            named: 'filter',
          ),
        ),
      ).thenAnswer((_) async => Either<List<Absence>>.r(failure));

      final Either<List<Absence>> result = await useCase.getAllAbsences(
        filter: filter,
      );

      expect(result.r, failure);
    });
  });

  group('[getAllAbsences] tests', () {
    const int memberUserId = 1;

    final AbsenceFilter filter = AbsenceFilter(
      type: AbsenceType.vacation,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 1)),
    );

    tearDown(() {
      verify(
        () => absencesRepository.getAbsences(
          filter: filter,
          userId: memberUserId,
        ),
      ).called(1);
      verifyNoMoreInteractions(absencesRepository);
    });

    test('Successful', () async {
      final List<Absence> absences = List<Absence>.generate(
        2,
        (int i) => Absence(
          id: i,
          member: Member(
            id: i,
            userId: memberUserId,
            crewId: memberUserId + 2,
            name: 'Member $memberUserId',
          ),
          createdAt: DateTime.now(),
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 1)),
          type: i.isEven ? AbsenceType.sickness : AbsenceType.vacation,
        ),
      );

      when(
        () => absencesRepository.getAbsences(
          filter: any(named: 'filter'),
          userId: any(named: 'userId'),
        ),
      ).thenAnswer((_) async => Either<List<Absence>>.l(absences));

      final Either<List<Absence>> result = await useCase.getAbsencesByMember(
        memberUserId,
        filter: filter,
      );

      expect(result.l, absences);
    });

    test('Failure', () async {
      const Failure failure = Failure();

      when(
        () => absencesRepository.getAbsences(
          filter: any(named: 'filter'),
          userId: any(named: 'userId'),
        ),
      ).thenAnswer((_) async => Either<List<Absence>>.r(failure));

      final Either<List<Absence>> result = await useCase.getAbsencesByMember(
        memberUserId,
        filter: filter,
      );

      expect(result.r, failure);
    });
  });
}
