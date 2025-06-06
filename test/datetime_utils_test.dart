import 'package:flutter_test/flutter_test.dart';
import 'package:novelglide/core/utils/datetime_utils.dart';

void main() {
  group('DateTimeUtils', () {
    test('daysBetween returns correct number of days', () {
      final DateTime from = DateTime(2023, 10, 1);
      final DateTime to = DateTime(2023, 10, 10);
      expect(DateTimeUtils.daysBetween(from, to), 9);
    });

    test('daysPassed returns correct number of days from a past date', () {
      final DateTime from = DateTime.now().subtract(const Duration(days: 5));
      expect(DateTimeUtils.daysPassed(from), 5);
    });

    test('format returns formatted date string', () {
      final DateTime dateTime = DateTime(2023, 10, 1, 14, 30);
      const String pattern = 'yyyy-MM-dd HH:mm';
      expect(
          DateTimeUtils.format(dateTime, pattern: pattern), '2023-10-01 14:30');
    });

    test('format returns default value when dateTime is null', () {
      const String defaultValue = 'N/A';
      expect(
          DateTimeUtils.format(null, defaultValue: defaultValue), defaultValue);
    });

    test('iso8601ToDateTime returns correct DateTime', () {
      final DateTime iso8601 = DateTime.parse('2023-10-01T14:30:00Z');
      const String pattern = 'yyyy-MM-dd HH:mm';
      expect(
          DateTimeUtils.format(iso8601, pattern: pattern), '2023-10-01 22:30');
    });
  });
}
