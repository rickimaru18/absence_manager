import 'package:equatable/equatable.dart';

import '../../core/core.dart';
import '../domain.dart';

// ignore: must_be_immutable
class AbsenceFilter with EquatableMixin {
  AbsenceFilter({
    this.type,
    this.startDate,
    this.endDate,
  });

  AbsenceType? type;
  DateTime? startDate;
  DateTime? endDate;

  bool get hasFilter => type != null || startDate != null || endDate != null;

  void clear() {
    type = null;
    startDate = null;
    endDate = null;
  }

  Json? toQueryParam() {
    if (!hasFilter) {
      return null;
    }

    return <String, dynamic>{
      if (type != null) 'type': 'eq.${type!.name}',
      if (startDate != null) 'startDate': 'gte.${startDate!.yyyyMMdd()}',
      if (endDate != null) 'endDate': 'lte.${endDate!.yyyyMMdd()}',
    };
  }

  @override
  List<Object?> get props => <Object?>[
        type,
        startDate,
        endDate,
      ];
}
