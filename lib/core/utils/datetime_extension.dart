import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format(String? pattern) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(toLocal());
  }
}
