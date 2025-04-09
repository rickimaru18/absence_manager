import 'package:get_it/get_it.dart';

import 'use_cases/absences_use_case.dart';
import 'use_cases/members_use_case.dart';

export 'models/absence.dart';
export 'models/member.dart';
export 'use_cases/absences_use_case.dart';
export 'use_cases/members_use_case.dart';

void setupDomainDi() {
  final GetIt getIt = GetIt.I;

  getIt
    ..registerFactory<AbsencesUseCase>(() => AbsencesUseCase(getIt()))
    ..registerFactory<MembersUseCase>(() => MembersUseCase(getIt()));
}
