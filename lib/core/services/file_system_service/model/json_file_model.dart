part of '../file_system_service.dart';

class JsonFileModel extends Equatable {
  const JsonFileModel(this._file, this._fallbackValue);

  final File _file;
  final String _fallbackValue;

  Map<String, dynamic> get data {
    String jsonString = _file.readAsStringSync();
    jsonString = jsonString.isEmpty ? _fallbackValue : jsonString;
    try {
      _file.writeAsStringSync(jsonString);
      return jsonDecode(jsonString);
    } catch (e) {
      _file.writeAsStringSync(_fallbackValue);
      return <String, dynamic>{};
    }
  }

  set data(Map<String, dynamic> value) {
    _file.writeAsStringSync(jsonEncode(value));
  }

  File get file => _file;

  String get path => _file.path;

  String get baseName => basename(path);

  @override
  List<Object?> get props => <Object?>[
        _file,
        _fallbackValue,
      ];

  void clear() {
    _file.writeAsStringSync(_fallbackValue);
  }
}
