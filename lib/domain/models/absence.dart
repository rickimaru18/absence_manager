import 'package:json_annotation/json_annotation.dart';

import '../../core/core.dart';
import '../domain.dart';

part 'absence.g.dart';

@JsonSerializable(createToJson: false)
class Absence {
  const Absence({
    required this.id,
    required this.member,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.type,
    this.memberNote = '',
    this.admitterId,
    this.admitterNote = '',
    this.confirmedAt,
    this.rejectedAt,
  });

  factory Absence.fromJson(Json json) => _$AbsenceFromJson(json);

  final int id;
  final Member member;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final AbsenceType type;
  final String memberNote;
  final int? admitterId;
  final String admitterNote;
  final DateTime? confirmedAt;
  final DateTime? rejectedAt;

  AbsenceStatus get status => isConfirmed
      ? AbsenceStatus.confirmed
      : isRejected
          ? AbsenceStatus.rejected
          : AbsenceStatus.requested;

  bool get isConfirmed => confirmedAt != null;

  bool get isRejected => rejectedAt != null;
}

enum AbsenceType {
  sickness,
  vacation,
}

enum AbsenceStatus {
  requested,
  confirmed,
  rejected,
}
