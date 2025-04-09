part of '../home_page.dart';

class _AbsenceList extends StatelessWidget {
  const _AbsenceList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageVm, HomePageState>(
      builder: (_, HomePageState state) {
        if (state.isLoading && state.absences.isEmpty) {
          return const CenterLoader();
        } else if (state.error != null) {
          return SingleChildScrollView(
            child: TryAgainError(
              onTryAgain: context.read<HomePageVm>().refresh,
              error: state.error,
            ),
          );
        } else if (state.absences.isEmpty) {
          return TryAgainEmpty(
            onRefresh: context.read<HomePageVm>().refresh,
          );
        }

        return RefreshIndicator(
          onRefresh: context.read<HomePageVm>().refresh,
          child: ListView.builder(
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
