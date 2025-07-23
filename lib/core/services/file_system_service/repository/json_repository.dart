part of '../file_system_service.dart';

class JsonRepository {
  const JsonRepository();

  JsonFileModel getJsonFile(File file, {String fallbackValue = '{}'}) {
    return JsonFileModel(file, fallbackValue);
  }
}
