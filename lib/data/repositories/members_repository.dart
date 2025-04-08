import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data_sources/remote/supabase_data_source.dart';
import '../data_sources/remote/supabase_tables.dart';

class MembersRepository {
  const MembersRepository(this.supabaseDataSource);

  final SupabaseDataSource supabaseDataSource;

  String get _table => SupabaseTables.member.name;

  Future<Either<List<Member>>> getMembers() =>
      supabaseDataSource.get<List<Member>>(
        _table,
        jsonListDecoder: (JsonList jsonList) =>
            jsonList.map(Member.fromJson).toList(),
      );
}
