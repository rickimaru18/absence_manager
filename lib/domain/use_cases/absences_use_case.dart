import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

class AbsencesUseCase {
  const AbsencesUseCase(this.absencesRepository);

  final AbsencesRepository absencesRepository;

  Future<Either<List<Absence>>> getAllAbsences() =>
      absencesRepository.getAbsences();

  Future<Either<List<Absence>>> getAbsencesByMember(int userId) =>
      absencesRepository.getAbsences(
        userId: userId,
      );
}
