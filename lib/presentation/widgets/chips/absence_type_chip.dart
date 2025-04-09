import 'package:flutter/material.dart';

import '../../../domain/domain.dart';

class AbsenceTypeChip extends StatelessWidget {
  const AbsenceTypeChip({
    required this.type,
    super.key,
  });

  final AbsenceType type;

  @override
  Widget build(BuildContext context) {
    final IconData icon = switch (type) {
      AbsenceType.vacation => Icons.flight_takeoff_rounded,
      AbsenceType.sickness => Icons.local_hospital_rounded,
    };

    return Chip(
      avatar: Icon(icon),
      label: Text(type.name),
    );
  }
}
