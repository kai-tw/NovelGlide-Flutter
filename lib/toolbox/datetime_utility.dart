import 'package:intl/intl.dart';

class DateTimeUtility {
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static int daysPassed(DateTime from) {
    return daysBetween(from, DateTime.now());
  }

  static String format(DateTime? dateTime, {String? pattern, String defaultValue = ''}) {
    return dateTime != null ? DateFormat().format(dateTime) : defaultValue;
  }

  DateTimeUtility._();
}