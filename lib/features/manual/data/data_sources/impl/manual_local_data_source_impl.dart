import 'package:flutter/services.dart';

import '../manual_local_data_source.dart';

class ManualLocalDataSourceImpl implements ManualLocalDataSource {
  @override
  Future<String> loadManual(String assetPath) {
    return rootBundle.loadString(assetPath);
  }
}
