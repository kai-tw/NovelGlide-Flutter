import 'package:flutter_test/flutter_test.dart';
import 'package:novelglide/utils/datetime_utils.dart';

void main() {
  group('DateTimeUtility', () {
    test('daysBetween returns correct number of days', () {
      final from = DateTime(2023, 10, 1);
      final to = DateTime(2023, 10, 10);
      expect(DateTimeUtils.daysBetween(from, to), 9);
    });

    test('daysPassed returns correct number of days from a past date', () {
      final from = DateTime.now().subtract(const Duration(days: 5));
      expect(DateTimeUtils.daysPassed(from), 5);
    });

    test('format returns formatted date string', () {
      final dateTime = DateTime(2023, 10, 1, 14, 30);
      const pattern = 'yyyy-MM-dd HH:mm';
      expect(
          DateTimeUtils.format(dateTime, pattern: pattern), '2023-10-01 14:30');
    });

    test('format returns default value when dateTime is null', () {
      const defaultValue = 'N/A';
      expect(
          DateTimeUtils.format(null, defaultValue: defaultValue), defaultValue);
    });

    test('iso8601ToDateTime returns correct DateTime', () {
      final iso8601 = DateTime.parse('2023-10-01T14:30:00Z');
      const pattern = 'yyyy-MM-dd HH:mm';
      expect(
          DateTimeUtils.format(iso8601, pattern: pattern), '2023-10-01 22:30');
    });
  });
}
