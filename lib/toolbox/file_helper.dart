import 'dart:math';

import 'package:path/path.dart';

/// A utility class for file-related operations.
class FileHelper {
  // Private constructor to prevent instantiation of this utility class.
  FileHelper._();

  /// Converts a file size in bytes to a human-readable string with units.
  ///
  /// [size] is the file size in bytes.
  /// [decimals] specifies the number of decimal places to include in the result.
  /// Returns a string representation of the file size with appropriate units.
  static String getFileSizeString(int size, {int decimals = 2}) {
    // List of units for file sizes.
    const List<String> units = [
      'B', // Bytes
      'KB', // Kilobytes
      'MB', // Megabytes
      'GB', // Gigabytes
      'TB', // Terabytes
      'PB', // Petabytes
      'EB', // Exabytes
      'ZB', // Zettabytes
      'YB' // Yottabytes
    ];

    // Ensure the size is not negative.
    size = max(size, 0);

    // Determine the index for the appropriate unit.
    int index = size > 0 ? (log(size) / log(1024)).floor() : 0;

    // Ensure index does not exceed the units list length.
    index = min(index, units.length - 1);

    // Format the size with the specified number of decimal places.
    double fileSize = size / pow(1024, index);
    return '${fileSize.toStringAsFixed(decimals)} ${units[index]}';
  }

  static String getAbsolutePath(String path, String root) {
    return isAbsolute(path) ? path : join(root, path);
  }

  static String getRelativePath(String path, String root) {
    return isRelative(path) ? path : relative(path, from: root);
  }
}
