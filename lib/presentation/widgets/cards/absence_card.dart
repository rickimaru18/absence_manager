import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../avatars/member_avatar.dart';
import '../chips/absence_status_chip.dart';
import '../chips/absence_type_chip.dart';

class AbsenceCard extends StatelessWidget {
  const AbsenceCard({
    required this.absence,
    super.key,
  });

  final Absence absence;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.d16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _Header(absence),
            const SizedBox(height: Dimens.d8),
            _Footer(absence),
          ],
        ),
      ),
    );
  }
}

//------------------------------------------------------------------------------
class _Header extends StatelessWidget {
  const _Header(this.absence);

  final Absence absence;

  Widget _buildMemberName() => Text(
        absence.member.name,
        style: const TextStyle(
          fontSize: Dimens.d16,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _buildChips() => Row(
        children: <Widget>[
          AbsenceTypeChip(
            type: absence.type,
          ),
          const SizedBox(width: Dimens.d8),
          AbsenceStatusChip(
            status: absence.status,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MemberAvatar(
          member: absence.member,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildMemberName(),
              Text('${absence.startDate.yMEd()} ~ ${absence.endDate.yMEd()}'),
              _buildChips(),
            ],
          ),
        ),
      ],
    );
  }
}

//------------------------------------------------------------------------------
class _Footer extends StatelessWidget {
  const _Footer(this.absence);

  final Absence absence;

  Widget _buildNoteText(String text) => Text(
        '$text :',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final bool hasMemberNote = absence.memberNote.trim().isNotEmpty;
    final bool hasAdmitterNote = absence.admitterNote.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (hasMemberNote) _buildNoteText('Note'),
        if (hasMemberNote) Text(absence.memberNote.trim()),
        if (hasMemberNote && hasAdmitterNote) const SizedBox(height: Dimens.d8),
        if (hasAdmitterNote) _buildNoteText('Admitter Note'),
        if (hasAdmitterNote) Text(absence.admitterNote.trim()),
      ],
    );
  }
}
