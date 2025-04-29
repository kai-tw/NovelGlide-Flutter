import 'dart:convert';
import 'dart:io';

class JsonUtils {
  JsonUtils._();

  static Map<String, dynamic> fromFile(File file) {
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
