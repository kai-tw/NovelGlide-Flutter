import 'package:firebase_analytics/firebase_analytics.dart';

import '../log_data_source.dart';

class FirebaseAnalyticsAdapter extends LogDataSource {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> info(String message) async {
    // You can use a custom event for informational logs.
    await _analytics.logEvent(
      name: 'info_log',
      parameters: {'message': message},
    );
  }

  @override
  Future<void> error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) async {
    // For errors, you can log a specific error event.
    await _analytics.logEvent(
      name: 'app_error',
      parameters: {
        'message': message,
        'error_type': error?.runtimeType.toString() ?? 'RuntimeType is null',
      },
    );
  }

  @override
  Future<void> fatal(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) async {
    // For fatal errors, you might log a different event.
    await _analytics.logEvent(
      name: 'fatal_error',
      parameters: {
        'message': message,
        'error_type': error?.runtimeType.toString() ?? 'RuntimeType is null',
      },
    );
  }
}
