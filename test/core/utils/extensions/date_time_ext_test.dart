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

  test('[yMd] checks', () {
    final DateTime firstDayOfYear = DateTime(2025);

    expect(firstDayOfYear.yMd(), '1/1/2025');
    expect(firstDayOfYear.add(const Duration(days: 1)).yMd(), '1/2/2025');
    expect(
      firstDayOfYear.subtract(const Duration(days: 1)).yMd(),
      '12/31/2024',
    );
  });

  test('[yyyyMMdd] checks', () {
    final DateTime firstDayOfYear = DateTime(2025);

    expect(firstDayOfYear.yyyyMMdd(), '2025-01-01');
    expect(
      firstDayOfYear.add(const Duration(days: 1)).yyyyMMdd(),
      '2025-01-02',
    );
    expect(
      firstDayOfYear.subtract(const Duration(days: 1)).yyyyMMdd(),
      '2024-12-31',
    );
  });
}
