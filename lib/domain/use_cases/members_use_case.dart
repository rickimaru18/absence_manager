import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

class MembersUseCase {
  const MembersUseCase(this.membersRepository);

  final MembersRepository membersRepository;

  Future<Either<List<Member>>> getAllMembers() =>
      membersRepository.getMembers();
}
