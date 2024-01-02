import 'dart:collection';

import 'package:novelglide/core/stream_builder.dart';

class StreamBuilderUtility {
  static StreamBuilderUtility? _instance;
  static StreamBuilderUtility get instance => _getInstance();
  final HashMap<String, CustomStreamBuilder> dataMap = HashMap();

  StreamBuilderUtility._();

  factory StreamBuilderUtility() {
    return instance;
  }

  static StreamBuilderUtility _getInstance() {
    _instance ??= StreamBuilderUtility._();
    return _instance ?? StreamBuilderUtility._();
  }

  CustomStreamBuilder getStream(String key) {
    if (!dataMap.containsKey(key)) {
      CustomStreamBuilder streamBuilder = CustomStreamBuilder.instance(key);
      dataMap[key] = streamBuilder;
    }
    return dataMap[key] ?? CustomStreamBuilder.instance(key);
  }

  void disposeAll() {
    if (dataMap.isNotEmpty) {
      for (var streamBuilder in dataMap.values) {
        streamBuilder.dispose();
      }
      dataMap.clear();
    }
  }

  void disposeByKey(String? key) {
    if (dataMap.isNotEmpty) {
      dataMap.remove(key);
    }
  }
}