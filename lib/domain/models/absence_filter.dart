import '../../core/core.dart';
import '../domain.dart';

class AbsenceFilter {
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
}
