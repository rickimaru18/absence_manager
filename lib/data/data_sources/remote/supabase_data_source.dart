import '../../../core/core.dart';

class SupabaseDataSource extends RestClientDataSource {
  SupabaseDataSource()
      : super(
          const String.fromEnvironment('SUPABASE_BASE_URL'),
          headers: <String, dynamic>{
            'apikey': const String.fromEnvironment('SUPABASE_API_KEY'),
          },
        );
}
