part of '../home_page.dart';

class _AbsenceList extends StatelessWidget {
  const _AbsenceList();

  @override
  Widget build(BuildContext context) {
    final HomePageVm vm = context.read<HomePageVm>();

    return BlocBuilder<HomePageVm, HomePageState>(
      builder: (_, HomePageState state) {
        if (state.isLoading && state.absences.isEmpty) {
          return const CenterLoader();
        } else if (state.error != null) {
          return SingleChildScrollView(
            child: TryAgainError(
              onTryAgain: vm.refresh,
              error: state.error,
            ),
          );
        } else if (state.absences.isEmpty) {
          return TryAgainEmpty(
            onRefresh: vm.refresh,
          );
        }

        return PaginatedListView(
          onRefresh: vm.refresh,
          onNext: vm.onNext,
          hasNextPage: state.hasNextPage,
          child: SliverList.builder(
            itemCount: state.absences.length,
            itemBuilder: (_, int index) {
              final Absence absence = state.absences[index];

              return AbsenceCard(
                key: ValueKey<int>(absence.id),
                absence: absence,
              );
            },
          ),
        );
      },
    );
  }
}
