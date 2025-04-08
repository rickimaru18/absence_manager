import 'package:absence_manager/core/core.dart';
import 'package:absence_manager/data/data.dart';
import 'package:absence_manager/data/data_sources/remote/supabase_tables.dart';
import 'package:absence_manager/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late AbsencesRepository repository;
  late SupabaseDataSourceMock supabaseDataSource;

  setUp(() {
    supabaseDataSource = SupabaseDataSourceMock();
    repository = AbsencesRepository(supabaseDataSource);
  });

  group('[getAbsences] tests', () {
    const int userId = 1;

    tearDown(() {
      final String memberTable = SupabaseTables.member.name;

      verify(
        () => supabaseDataSource.get<List<Absence>>(
          SupabaseTables.absences.name,
          queryParameters: <String, dynamic>{
            'select': '*,$memberTable:$memberTable!inner(*)',
            'userId': 'eq.$userId',
          },
          jsonListDecoder: any(named: 'jsonListDecoder'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDataSource);
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
        () => supabaseDataSource.get<List<Absence>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          jsonListDecoder: any(named: 'jsonListDecoder'),
        ),
      ).thenAnswer((_) async => Either<List<Absence>>.l(absences));

      final Either<List<Absence>> result = await repository.getAbsences(
        userId: userId,
      );

      expect(result.l, absences);
    });

    test('Failure', () async {
      const Failure failure = Failure();

      when(
        () => supabaseDataSource.get<List<Absence>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
          jsonListDecoder: any(named: 'jsonListDecoder'),
        ),
      ).thenAnswer((_) async => Either<List<Absence>>.r(failure));

      final Either<List<Absence>> result = await repository.getAbsences(
        userId: userId,
      );

      expect(result.r, failure);
    });
  });
}
