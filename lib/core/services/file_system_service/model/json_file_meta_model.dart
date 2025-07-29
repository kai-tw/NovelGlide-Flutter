part of '../file_system_service.dart';

class JsonFileMetaModel extends FileMetaModel {
  const JsonFileMetaModel({
    required super.file,
    required this.fallbackValue,
  });

  final String fallbackValue;

  Map<String, dynamic> get data {
    String jsonString = file.readAsStringSync();
    jsonString = jsonString.isEmpty ? fallbackValue : jsonString;
    try {
      file.writeAsStringSync(jsonString);
      return jsonDecode(jsonString);
    } catch (e) {
      file.writeAsStringSync(fallbackValue);
      return <String, dynamic>{};
    }
  }

  set data(Map<String, dynamic> value) {
    file.writeAsStringSync(jsonEncode(value));
  }

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        fallbackValue,
      ];

  void clear() {
    file.writeAsStringSync(fallbackValue);
  }
}
