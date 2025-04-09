import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data_sources/remote/supabase_data_source.dart';
import '../data_sources/remote/supabase_tables.dart';

class AbsencesRepository {
  const AbsencesRepository(this.supabaseDataSource);

  final SupabaseDataSource supabaseDataSource;

  String get _table => SupabaseTables.absences.name;

  Future<Either<List<Absence>>> getAbsences({
    AbsenceFilter? filter,
    int? userId,
  }) {
    final String memberTable = SupabaseTables.member.name;

    return supabaseDataSource.get<List<Absence>>(
      _table,
      queryParameters: <String, dynamic>{
        'select': '*,$memberTable:$memberTable!inner(*)',
        if (userId != null) 'userId': 'eq.$userId',
        if (filter?.hasFilter ?? false) ...filter!.toQueryParam()!,
      },
      jsonListDecoder: (JsonList jsonList) =>
          jsonList.map(Absence.fromJson).toList(),
    );
  }
}
