// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      crewId: (json['crewId'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String?,
    );
