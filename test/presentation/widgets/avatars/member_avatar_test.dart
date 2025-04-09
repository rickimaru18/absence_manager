import 'package:absence_manager/domain/domain.dart';
import 'package:absence_manager/presentation/widgets/avatars/member_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../build_widget.dart';

void main() {
  const Member member = Member(
    id: 1,
    userId: 1,
    crewId: 1,
    name: 'Member',
    image: 'https://loremflickr.com/300/400',
  );

  Future<void> build(
    WidgetTester tester, {
    Member? customMember,
  }) =>
      buildWidget(
        tester,
        MemberAvatar(
          member: customMember ?? member,
        ),
      );

  group('[UI checks]', () {
    testWidgets('Member with image will display network image', (
      WidgetTester tester,
    ) async {
      await build(tester);

      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.text(member.name[0].toUpperCase()), findsNothing);
    });

    testWidgets('Member with no image will display first letter of name', (
      WidgetTester tester,
    ) async {
      const Member customMember = Member(
        id: 1,
        userId: 1,
        crewId: 1,
        name: 'Custom Member',
      );

      await build(
        tester,
        customMember: customMember,
      );

      expect(find.byType(CachedNetworkImage), findsNothing);
      expect(find.text(customMember.name[0].toUpperCase()), findsOneWidget);
    });
  });

  // No event checks.
}
