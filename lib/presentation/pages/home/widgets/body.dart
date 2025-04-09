part of '../home_page.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        _FilterSection(),
        Expanded(
          child: _AbsenceList(),
        ),
      ],
    );
  }
}
