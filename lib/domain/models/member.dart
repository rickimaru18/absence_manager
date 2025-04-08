import 'package:json_annotation/json_annotation.dart';

import '../../core/core.dart';

part 'member.g.dart';

@JsonSerializable(createToJson: false)
class Member {
  const Member({
    required this.id,
    required this.userId,
    required this.crewId,
    required this.name,
    this.image,
  });

  factory Member.fromJson(Json json) => _$MemberFromJson(json);

  final int id;
  final int userId;
  final int crewId;
  final String name;
  final String? image;
}
