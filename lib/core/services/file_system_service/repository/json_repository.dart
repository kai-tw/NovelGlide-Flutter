part of '../file_system_service.dart';

class JsonRepository {
  const JsonRepository();

  JsonFileMetaModel getJsonFile(File file, {String fallbackValue = '{}'}) {
    return JsonFileMetaModel(
      file: file,
      fallbackValue: fallbackValue,
    );
  }
}
