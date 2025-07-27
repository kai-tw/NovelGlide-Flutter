part of '../file_system_service.dart';

class JsonFileMetaModel extends FileMetaModel {
  const JsonFileMetaModel(super.file, this._fallbackValue);

  final String _fallbackValue;

  Map<String, dynamic> get data {
    String jsonString = file.readAsStringSync();
    jsonString = jsonString.isEmpty ? _fallbackValue : jsonString;
    try {
      file.writeAsStringSync(jsonString);
      return jsonDecode(jsonString);
    } catch (e) {
      file.writeAsStringSync(_fallbackValue);
      return <String, dynamic>{};
    }
  }

  set data(Map<String, dynamic> value) {
    file.writeAsStringSync(jsonEncode(value));
  }

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        _fallbackValue,
      ];

  void clear() {
    file.writeAsStringSync(_fallbackValue);
  }
}
