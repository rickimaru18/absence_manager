import '../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

class AbsencesUseCase {
  const AbsencesUseCase(this.absencesRepository);

  final AbsencesRepository absencesRepository;

  Future<Either<List<Absence>>> getAllAbsences({
    AbsenceFilter? filter,
    required int offset,
    int? limit,
  }) =>
      absencesRepository.getAbsences(
        filter: filter,
        offset: offset,
        limit: limit,
      );

  Future<Either<List<Absence>>> getAbsencesByMember({
    AbsenceFilter? filter,
    required int userId,
    required int offset,
    int? limit,
  }) =>
      absencesRepository.getAbsences(
        filter: filter,
        userId: userId,
        offset: offset,
        limit: limit,
      );
}
