import 'dart:convert';
import 'dart:io';

import '../exceptions/file_exceptions.dart';

class JsonUtils {
  static Map<String, dynamic> fromPath(String path) {
    return fromFile(File(path));
  }

  static Map<String, dynamic> fromFile(File file) {
    if (!file.existsSync()) {
      throw FileNotFoundException();
    }
    String jsonString = file.readAsStringSync();
    jsonString = jsonString.isEmpty ? '{}' : jsonString;
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      return {};
    }
  }
}
