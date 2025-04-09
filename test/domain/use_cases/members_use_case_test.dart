import 'package:absence_manager/core/core.dart';
import 'package:absence_manager/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late MembersUseCase useCase;
  late MembersRepositoryMock membersRepository;

  setUp(() {
    membersRepository = MembersRepositoryMock();
    useCase = MembersUseCase(membersRepository);
  });

  group('[getAllMembers] tests', () {
    tearDown(() {
      verify(() => membersRepository.getMembers()).called(1);
      verifyNoMoreInteractions(membersRepository);
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

      when(() => membersRepository.getMembers())
          .thenAnswer((_) async => Either<List<Member>>.l(members));

      final Either<List<Member>> result = await useCase.getAllMembers();

      expect(result.l, members);
    });

    test('Failure', () async {
      const Failure failure = Failure();

      when(() => membersRepository.getMembers())
          .thenAnswer((_) async => Either<List<Member>>.r(failure));

      final Either<List<Member>> result = await useCase.getAllMembers();

      expect(result.r, failure);
    });
  });
}
