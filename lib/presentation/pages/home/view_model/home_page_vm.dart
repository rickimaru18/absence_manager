import '../../../../core/core.dart';
import '../../../../domain/domain.dart';
import 'home_page_state.dart';

export 'home_page_state.dart';

class HomePageVm extends AppCubit<HomePageState> {
  HomePageVm(this.absencesUseCase) : super(const HomePageState());

  final AbsencesUseCase absencesUseCase;

  @override
  void init() => getAbsences();

  Future<void> getAbsences() async {
    emit(state.copyWith(isLoading: true));

    final Either<List<Absence>> result = await absencesUseCase.getAllAbsences();

    result.handle(
      (List<Absence> l) => emit(
        state.copyWith(
          absences: l,
          error: null,
          isLoading: false,
        ),
      ),
      (Failure r) => emit(
        state.copyWith(
          error: r,
          isLoading: false,
        ),
      ),
    );
  }

  Future<void> refresh() => getAbsences();
}
