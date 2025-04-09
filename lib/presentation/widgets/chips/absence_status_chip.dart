import 'package:flutter/material.dart';

import '../../../domain/domain.dart';

class AbsenceStatusChip extends StatelessWidget {
  const AbsenceStatusChip({
    required this.status,
    super.key,
  });

  final AbsenceStatus status;

  @override
  Widget build(BuildContext context) {
    final Color color = switch (status) {
      AbsenceStatus.requested => Colors.lightBlue,
      AbsenceStatus.confirmed => Colors.lightGreen,
      AbsenceStatus.rejected => Colors.red,
    };

    return Chip(
      backgroundColor: color,
      label: Text(
        status.name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
