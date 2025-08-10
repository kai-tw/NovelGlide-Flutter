import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../log_data_source.dart';

class FirebaseCrashlyticsAdapter extends LogDataSource {
  FirebaseCrashlyticsAdapter(this._instance);

  final FirebaseCrashlytics _instance;

  @override
  Future<void> error(String message, {Object? error, StackTrace? stackTrace}) {
    return _instance.recordError(
      Exception(message),
      stackTrace,
      reason: message,
      fatal: false,
    );
  }

  @override
  Future<void> fatal(String message, {Object? error, StackTrace? stackTrace}) {
    return _instance.recordError(
      Exception(message),
      stackTrace,
      reason: message,
      fatal: true,
    );
  }

  @override
  Future<void> info(String message) {
    return _instance.log('Info: $message');
  }

  @override
  Future<void> event(String name, {Map<String, dynamic>? parameters}) async {
    // No-ops
  }
}
