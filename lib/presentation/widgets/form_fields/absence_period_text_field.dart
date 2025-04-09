import 'package:flutter/material.dart';

import '../../../core/core.dart';

typedef OnPeriodChanged = void Function(DateTime? start, DateTime? end);

class AbsencePeriodTextField extends StatefulWidget {
  const AbsencePeriodTextField({
    required this.onPeriodChanged,
    this.initialStartDate,
    this.initialEndDate,
    super.key,
  });

  final OnPeriodChanged onPeriodChanged;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  @override
  State<StatefulWidget> createState() => _AbsencePeriodTextFieldState();
}

class _AbsencePeriodTextFieldState extends State<AbsencePeriodTextField> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  late DateTime? _startDate = widget.initialStartDate;
  late DateTime? _endDate = widget.initialEndDate;

  Future<void> _onShowDatePicker(BuildContext context, bool isStartDate) async {
    final DateTime now = DateTime.now();
    final DateTime? date = await showDatePicker(
      context: context,
      firstDate:
          (isStartDate || _startDate == null) ? DateTime(1990) : _startDate!,
      lastDate: DateTime(now.year + 1, now.month, now.day),
      initialDate: isStartDate
          ? (widget.initialStartDate ?? now)
          : (widget.initialEndDate ?? now),
      currentDate: now,
    );

    if (date == null) {
      return;
    }

    if (isStartDate) {
      setState(() => _startDate = date);
      _startDateController.text = date.yMd();
    } else {
      setState(() => _endDate = date);
      _endDateController.text = date.yMd();
    }

    widget.onPeriodChanged(_startDate, _endDate);
  }

  void _onClearText(bool isStartDate) {
    if (isStartDate) {
      setState(() => _startDate = null);
      _startDateController.clear();
    } else {
      setState(() => _endDate = null);
      _endDateController.clear();
    }
  }

  Widget _buildClearButton(bool isStartDate) => IconButton(
        onPressed: () => _onClearText(isStartDate),
        icon: const Icon(Icons.close),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AppTextField(
            onTap: () => _onShowDatePicker(context, true),
            controller: _startDateController,
            label: 'Start Date',
            readOnly: true,
            suffixIcon: _startDate != null ? _buildClearButton(true) : null,
          ),
        ),
        Expanded(
          child: AppTextField(
            onTap: () => _onShowDatePicker(context, false),
            controller: _endDateController,
            label: 'End Date',
            readOnly: true,
            suffixIcon: _endDate != null ? _buildClearButton(false) : null,
          ),
        ),
      ],
    );
  }
}
