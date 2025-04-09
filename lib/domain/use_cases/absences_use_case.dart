import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

class AbsencesUseCase {
  const AbsencesUseCase(this.absencesRepository);

  final AbsencesRepository absencesRepository;

  Future<Either<List<Absence>>> getAllAbsences({
    AbsenceFilter? filter,
  }) =>
      absencesRepository.getAbsences(
        filter: filter,
      );

  Future<Either<List<Absence>>> getAbsencesByMember(
    int userId, {
    AbsenceFilter? filter,
  }) =>
      absencesRepository.getAbsences(
        filter: filter,
        userId: userId,
      );
}
