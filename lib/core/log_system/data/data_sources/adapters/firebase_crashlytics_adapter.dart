import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../log_data_source.dart';

class FirebaseCrashlyticsAdapter extends LogDataSource {
  final FirebaseCrashlytics _instance = FirebaseCrashlytics.instance;

  @override
  Future<void> error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) async {
    _instance.recordError(
      Exception(message),
      stackTrace,
      reason: message,
      fatal: false,
    );
  }

  @override
  Future<void> fatal(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) async {
    _instance.recordError(
      Exception(message),
      stackTrace,
      reason: message,
      fatal: true,
    );
  }

  @override
  Future<void> info(String message) async {
    _instance.log('Info: $message');
  }
}
