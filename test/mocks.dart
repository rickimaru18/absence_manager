import 'package:absence_manager/data/data.dart';
import 'package:absence_manager/data/data_sources/remote/supabase_data_source.dart';
import 'package:absence_manager/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

//------------------------------------------------------------------------------
// Data Sources
//------------------------------------------------------------------------------
class SupabaseDataSourceMock extends Mock implements SupabaseDataSource {}

//------------------------------------------------------------------------------
// Repositories
//------------------------------------------------------------------------------
class AbsencesRepositoryMock extends Mock implements AbsencesRepository {}

class MembersRepositoryMock extends Mock implements MembersRepository {}

//------------------------------------------------------------------------------
// Use Cases
//------------------------------------------------------------------------------
class AbsencesUseCaseMock extends Mock implements AbsencesUseCase {}

class MembersUseCaseMock extends Mock implements MembersUseCase {}
