import 'package:intl/intl.dart';

/// A utility class for common DateTime operations.
class DateTimeUtils {
  // Private constructor to prevent instantiation.
  DateTimeUtils._();

  /// Calculates the number of days between two [DateTime] objects.
  ///
  /// The [from] and [to] parameters are the start and end dates, respectively.
  /// Returns the number of full days between the two dates.
  static int daysBetween(DateTime from, DateTime to) {
    final DateTime startDate = DateTime(from.year, from.month, from.day);
    final DateTime endDate = DateTime(to.year, to.month, to.day);
    return (endDate.difference(startDate).inHours / 24).round();
  }

  /// Calculates the number of days passed since a given [DateTime].
  ///
  /// The [from] parameter is the start date.
  /// Returns the number of full days from the given date to the current date.
  static int daysPassed(DateTime from) {
    return daysBetween(from, DateTime.now());
  }

  /// Formats a [DateTime] object into a string based on the provided [pattern].
  ///
  /// The [dateTime] parameter is the date to format.
  /// The [pattern] parameter is the format pattern to use.
  /// The [defaultValue] is returned if [dateTime] is null.
  /// Returns a formatted date string or the [defaultValue] if [dateTime] is null.
  static String format(
    DateTime? dateTime, {
    String? pattern,
    String defaultValue = '',
  }) {
    if (dateTime == null) {
      return defaultValue;
    }
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(dateTime.toLocal());
  }
}
