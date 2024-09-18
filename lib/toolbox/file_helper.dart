import 'dart:math';

class FileHelper {
  static String getFileSizeString(int size, {int decimals = 2}) {
    final List<String> units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    size = max(size, 0);
    int index = (log(size) / log(1024)).floor();
    return '${(size / pow(1024, index)).toStringAsFixed(decimals)} ${units[index]}';
  }

  FileHelper._();
}