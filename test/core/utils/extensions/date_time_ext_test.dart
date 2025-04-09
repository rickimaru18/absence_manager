import 'package:absence_manager/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('[yMEd] checks', () {
    final DateTime firstDayOfYear = DateTime(2025);

    expect(firstDayOfYear.yMEd(), 'Wed, 1/1/2025');
    expect(firstDayOfYear.add(const Duration(days: 1)).yMEd(), 'Thu, 1/2/2025');
    expect(
      firstDayOfYear.subtract(const Duration(days: 1)).yMEd(),
      'Tue, 12/31/2024',
    );
  });
}
