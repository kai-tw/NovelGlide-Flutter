import 'package:firebase_analytics/firebase_analytics.dart';

import '../log_data_source.dart';

class FirebaseAnalyticsAdapter extends LogDataSource {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> info(String message) {
    return _analytics.logEvent(
      name: 'info_log',
      parameters: <String, Object>{'message': message},
    );
  }

  @override
  Future<void> error(String message, {Object? error, StackTrace? stackTrace}) {
    return _analytics.logEvent(
      name: 'app_error',
      parameters: <String, Object>{
        'message': message,
        'error_type': error?.runtimeType.toString() ?? 'RuntimeType is null',
      },
    );
  }

  @override
  Future<void> fatal(String message, {Object? error, StackTrace? stackTrace}) {
    return _analytics.logEvent(
      name: 'fatal_error',
      parameters: <String, Object>{
        'message': message,
        'error_type': error?.runtimeType.toString() ?? 'RuntimeType is null',
      },
    );
  }

  @override
  Future<void> event(String name, {Map<String, Object>? parameters}) {
    return _analytics.logEvent(name: name, parameters: parameters);
  }
}
