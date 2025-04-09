import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../widgets/cards/absence_card.dart';
import 'view_model/home_page_vm.dart';

export 'view_model/home_page_vm.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absence Manager'),
      ),
      body: BlocBuilder<HomePageVm, HomePageState>(
        builder: (_, HomePageState state) {
          if (state.isLoading && state.absences.isEmpty) {
            return const CenterLoader();
          } else if (state.error != null) {
            return TryAgainError(
              onTryAgain: context.read<HomePageVm>().refresh,
              error: state.error,
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
                  absence: state.absences[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
