import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  /// Format date to "Wed, 1/1/2025".
  String yMEd() => DateFormat.yMEd().format(this);

  /// Format date to "1/1/2025".
  String yMd() => DateFormat.yMd().format(this);

  /// Format date to "2025-01-01".
  String yyyyMMdd() => DateFormat('yyyy-MM-dd').format(this);
}
