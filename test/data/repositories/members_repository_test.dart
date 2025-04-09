import 'package:absence_manager/core/core.dart';
import 'package:absence_manager/data/data.dart';
import 'package:absence_manager/data/data_sources/remote/supabase_tables.dart';
import 'package:absence_manager/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late MembersRepository repository;
  late SupabaseDataSourceMock supabaseDataSource;

  setUp(() {
    supabaseDataSource = SupabaseDataSourceMock();
    repository = MembersRepository(supabaseDataSource);
  });

  group('[getMembers] tests', () {
    tearDown(() {
      verify(
        () => supabaseDataSource.get<List<Member>>(
          SupabaseTables.member.name,
          jsonListDecoder: any(named: 'jsonListDecoder'),
        ),
      ).called(1);
      verifyNoMoreInteractions(supabaseDataSource);
    });

    test('Successful', () async {
      final List<Member> members = List<Member>.generate(
        2,
        (int i) => Member(
          id: i,
          userId: i + 1,
          crewId: i + 2,
          name: 'Member $i',
        ),
      );

      when(
        () => supabaseDataSource.get<List<Member>>(
          any(),
          jsonListDecoder: any(named: 'jsonListDecoder'),
        ),
      ).thenAnswer((_) async => Either<List<Member>>.l(members));

      final Either<List<Member>> result = await repository.getMembers();

      expect(result.l, members);
    });

    test('Failure', () async {
      const Failure failure = Failure();

      when(
        () => supabaseDataSource.get<List<Member>>(
          any(),
          jsonListDecoder: any(named: 'jsonListDecoder'),
        ),
      ).thenAnswer((_) async => Either<List<Member>>.r(failure));

      final Either<List<Member>> result = await repository.getMembers();

      expect(result.r, failure);
    });
  });
}
