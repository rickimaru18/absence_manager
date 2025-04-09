import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';

class AbsenceTypeDropdownField extends StatelessWidget {
  const AbsenceTypeDropdownField({
    required this.onChanged,
    this.value,
    super.key,
  });

  final ValueChanged<AbsenceType?> onChanged;
  final AbsenceType? value;

  @override
  Widget build(BuildContext context) {
    return AppDropdownField<AbsenceType>(
      onChanged: onChanged,
      label: 'Type',
      value: value,
      items: AbsenceType.values,
    );
  }
}
