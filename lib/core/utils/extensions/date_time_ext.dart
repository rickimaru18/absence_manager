import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String yMEd() => DateFormat.yMEd().format(this);
}
