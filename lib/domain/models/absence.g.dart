// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Absence _$AbsenceFromJson(Map<String, dynamic> json) => Absence(
      id: (json['id'] as num).toInt(),
      member: Member.fromJson(json['member'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      type: $enumDecode(_$AbsenceTypeEnumMap, json['type']),
      memberNote: json['memberNote'] as String? ?? '',
      admitterId: (json['admitterId'] as num?)?.toInt(),
      admitterNote: json['admitterNote'] as String? ?? '',
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      rejectedAt: json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
    );

const _$AbsenceTypeEnumMap = {
  AbsenceType.sickness: 'sickness',
  AbsenceType.vacation: 'vacation',
};
