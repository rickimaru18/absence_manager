import 'package:get_it/get_it.dart';

import 'data_sources/remote/supabase_data_source.dart';
import 'repositories/absences_repository.dart';
import 'repositories/members_repository.dart';

export 'repositories/absences_repository.dart';
export 'repositories/members_repository.dart';

void setupDataDi() {
  final GetIt getIt = GetIt.I;

  getIt
    // Data Souces
    ..registerSingleton<SupabaseDataSource>(SupabaseDataSource())
    // Repositories
    ..registerFactory<AbsencesRepository>(() => AbsencesRepository(getIt()))
    ..registerFactory<MembersRepository>(() => MembersRepository(getIt()));
}
