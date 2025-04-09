import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import '../form_fields/absence_period_text_field.dart';
import '../form_fields/absence_type_dropdown_field.dart';

class AbsenceFilterForm extends StatefulWidget {
  const AbsenceFilterForm({
    required this.onFilter,
    this.filter,
    super.key,
  });

  final ValueChanged<AbsenceFilter> onFilter;
  final AbsenceFilter? filter;

  @override
  State<AbsenceFilterForm> createState() => _AbsenceFilterFormState();
}

class _AbsenceFilterFormState extends State<AbsenceFilterForm> {
  late AbsenceFilter _filter;

  @override
  void initState() {
    super.initState();
    _setFilterInitialState();
  }

  @override
  void didUpdateWidget(covariant AbsenceFilterForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.filter != widget.filter) {
      _setFilterInitialState();
    }
  }

  void _setFilterInitialState() => _filter = widget.filter ?? AbsenceFilter();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          AbsenceTypeDropdownField(
            onChanged: (AbsenceType? type) =>
                setState(() => _filter.type = type),
            value: _filter.type,
          ),
          AbsencePeriodTextField(
            onPeriodChanged: (DateTime? start, DateTime? end) => setState(
              () => _filter
                ..startDate = start
                ..endDate = end,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => widget.onFilter(_filter),
              child: const Text('Filter'),
            ),
          ),
        ],
      ),
    );
  }
}
