import 'package:flutter_test/flutter_test.dart';
import 'package:novelglide/toolbox/file_helper.dart';

void main() {
  group('FileHelper', () {
    test('getFileSizeString should return correct size for bytes', () {
      // Arrange
      const size = 500; // 500 bytes

      // Act
      final result = FileHelper.getFileSizeString(size);

      // Assert
      expect(result, '500.00 B');
    });

    test('getFileSizeString should return correct size for kilobytes', () {
      // Arrange
      const size = 1024; // 1 KB

      // Act
      final result = FileHelper.getFileSizeString(size);

      // Assert
      expect(result, '1.00 KB');
    });

    test('getFileSizeString should return correct size for megabytes', () {
      // Arrange
      const size = 1048576; // 1 MB

      // Act
      final result = FileHelper.getFileSizeString(size);

      // Assert
      expect(result, '1.00 MB');
    });

    test('getFileSizeString should handle zero size correctly', () {
      // Arrange
      const size = 0;

      // Act
      final result = FileHelper.getFileSizeString(size);

      // Assert
      expect(result, '0.00 B');
    });

    test('getFileSizeString should handle large sizes correctly', () {
      // Arrange
      const size = 1099511627776; // 1 TB

      // Act
      final result = FileHelper.getFileSizeString(size);

      // Assert
      expect(result, '1.00 TB');
    });
  });
}
