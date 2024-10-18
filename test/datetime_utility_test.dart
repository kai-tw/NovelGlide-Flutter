import 'package:flutter_test/flutter_test.dart';
import 'package:novelglide/toolbox/datetime_utility.dart';

void main() {
  group('DateTimeUtility', () {
    test(
        'daysBetween should calculate the correct number of days between two dates',
        () {
      // Arrange
      final from = DateTime(2023, 10, 1);
      final to = DateTime(2023, 10, 10);

      // Act
      final result = DateTimeUtility.daysBetween(from, to);

      // Assert
      expect(result, 9);
    });

    test(
        'daysPassed should calculate the correct number of days from a past date to now',
        () {
      // Arrange
      final from = DateTime.now().subtract(const Duration(days: 5));

      // Act
      final result = DateTimeUtility.daysPassed(from);

      // Assert
      expect(result, 5);
    });

    test(
        'format should return a formatted date string based on the provided pattern',
        () {
      // Arrange
      final dateTime = DateTime(2023, 10, 1);
      const pattern = 'yyyy-MM-dd';

      // Act
      final result = DateTimeUtility.format(dateTime, pattern: pattern);

      // Assert
      expect(result, '2023-10-01');
    });

    test('format should return the default value if dateTime is null', () {
      // Arrange
      const defaultValue = 'N/A';

      // Act
      final result = DateTimeUtility.format(null, defaultValue: defaultValue);

      // Assert
      expect(result, defaultValue);
    });
  });
}
