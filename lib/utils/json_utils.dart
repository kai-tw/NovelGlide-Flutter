import 'dart:convert';
import 'dart:io';

import '../exceptions/exceptions.dart';

class JsonUtils {
  JsonUtils._();

  static Map<String, dynamic> fromFile(File file) {
    if (!file.existsSync()) {
      throw FileNotFoundException();
    }
    String jsonString = file.readAsStringSync();
    jsonString = jsonString.isEmpty ? '{}' : jsonString;
    try {
      file.writeAsStringSync(jsonString);
      return jsonDecode(jsonString);
    } catch (e) {
      file.writeAsStringSync('{}');
      return <String, dynamic>{};
    }
  }
}
