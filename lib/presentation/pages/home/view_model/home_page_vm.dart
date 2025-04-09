import '../../../../core/core.dart';
import '../../../../domain/domain.dart';
import 'home_page_state.dart';

export 'home_page_state.dart';

class HomePageVm extends AppCubit<HomePageState> {
  HomePageVm(this.absencesUseCase) : super(const HomePageState());

  final AbsencesUseCase absencesUseCase;

  @override
  void init() => getAbsences();

  int get _pageSize => 10;

  Future<void> getAbsences() async {
    if (state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoading: true));

    final Either<List<Absence>> result = await absencesUseCase.getAllAbsences(
      filter: state.filter,
      offset: state.offset,
      limit: _pageSize,
    );

    result.handle(
      (List<Absence> l) {
        final List<Absence> newAbsences = state.offset == 0
            ? l
            : <Absence>[
                ...state.absences,
                ...l,
              ];

        emit(
          state.copyWith(
            absences: newAbsences,
            error: null,
            isLoading: false,
            hasNextPage: l.length == _pageSize,
          ),
        );
      },
      (Failure r) => emit(
        state.copyWith(
          error: r,
          isLoading: false,
        ),
      ),
    );
  }

  Future<void> refresh() async {
    emit(
      state.copyWith(
        error: null,
        offset: 0,
        isLoading: false,
        hasNextPage: true,
      ),
    );

    await getAbsences();
  }

  Future<void> filter(AbsenceFilter? filter) async {
    emit(
      state.copyWith(
        filter: filter,
        absences: <Absence>[],
        offset: 0,
        hasNextPage: true,
      ),
    );

    await getAbsences();
  }

  Future<void> onNext() async {
    if (!state.hasNextPage) {
      return;
    }

    emit(state.copyWith(offset: state.absences.length));

    await getAbsences();
  }
}
