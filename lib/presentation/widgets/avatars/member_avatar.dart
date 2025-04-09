import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';

class MemberAvatar extends StatelessWidget {
  const MemberAvatar({
    required this.member,
    super.key,
  });

  final Member member;

  Widget _buildDefaultAvatar() => CircleAvatar(
        radius: Dimens.d32,
        child: Text(member.name[0].toUpperCase()),
      );

  @override
  Widget build(BuildContext context) {
    final Widget child;

    if (member.image?.isNotEmpty ?? false) {
      child = CachedNetworkImage(
        errorWidget: (_, __, ___) => _buildDefaultAvatar(),
        width: Dimens.d64,
        height: Dimens.d64,
        imageUrl: member.image!,
      );
    } else {
      child = _buildDefaultAvatar();
    }

    return child;
  }
}
