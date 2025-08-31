import '../../domain/repositories/log_repository.dart';
import '../data_sources/adapters/firebase_analytics_adapter.dart';
import '../data_sources/adapters/firebase_crashlytics_adapter.dart';
import '../data_sources/adapters/logger_adapter.dart';

class LogRepositoryImpl extends LogRepository {
  LogRepositoryImpl(
    this._loggerAdapter,
    this._firebaseCrashlyticsAdapter,
    this._firebaseAnalyticsAdapter,
  );

  final LoggerAdapter _loggerAdapter;
  final FirebaseCrashlyticsAdapter _firebaseCrashlyticsAdapter;
  final FirebaseAnalyticsAdapter _firebaseAnalyticsAdapter;

  @override
  Future<void> info(String message) {
    return Future.wait(<Future<void>>[
      _loggerAdapter.info(message),
      _firebaseCrashlyticsAdapter.info(message),
      _firebaseAnalyticsAdapter.info(message),
    ]);
  }

  @override
  Future<void> warn(String message) {
    return Future.wait(<Future<void>>[
      _loggerAdapter.warn(message),
      _firebaseCrashlyticsAdapter.warn(message),
      _firebaseAnalyticsAdapter.warn(message),
    ]);
  }

  @override
  Future<void> error(String message, {Object? error, StackTrace? stackTrace}) {
    return Future.wait(<Future<void>>[
      _loggerAdapter.error(message, error: error, stackTrace: stackTrace),
      _firebaseCrashlyticsAdapter.error(message,
          error: error, stackTrace: stackTrace),
      _firebaseAnalyticsAdapter.error(message,
          error: error, stackTrace: stackTrace),
    ]);
  }

  @override
  Future<void> fatal(String message, {Object? error, StackTrace? stackTrace}) {
    return Future.wait(<Future<void>>[
      _loggerAdapter.fatal(message, error: error, stackTrace: stackTrace),
      _firebaseCrashlyticsAdapter.fatal(message,
          error: error, stackTrace: stackTrace),
      _firebaseAnalyticsAdapter.fatal(message,
          error: error, stackTrace: stackTrace),
    ]);
  }

  @override
  Future<void> event(String name, {Map<String, Object>? parameters}) {
    return Future.wait(<Future<void>>[
      _loggerAdapter.event(name, parameters: parameters),
      _firebaseAnalyticsAdapter.event(name, parameters: parameters),
    ]);
  }
}
