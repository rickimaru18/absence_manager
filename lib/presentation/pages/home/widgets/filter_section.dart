part of '../home_page.dart';

class _FilterSection extends StatelessWidget {
  const _FilterSection();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Filter'),
      children: <Widget>[
        BlocSelector<HomePageVm, HomePageState, AbsenceFilter?>(
          selector: (HomePageState state) => state.filter,
          builder: (_, AbsenceFilter? filter) => AbsenceFilterForm(
            onFilter: context.read<HomePageVm>().filter,
            filter: filter,
          ),
        ),
      ],
    );
  }
}
