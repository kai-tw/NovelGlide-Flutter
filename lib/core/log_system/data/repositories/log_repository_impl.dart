import '../../domain/repositories/log_repository.dart';
import '../data_sources/adapters/firebase_analytics_adapter.dart';
import '../data_sources/adapters/firebase_crashlytics_adapter.dart';
import '../data_sources/adapters/logger_adapter.dart';

class LogRepositoryImpl extends LogRepository {
  LogRepositoryImpl(
    this._loggerDataSource,
    this._firebaseCrashlyticsDataSourceImpl,
    this._firebaseAnalyticsDataSource,
  );

  final LoggerAdapter _loggerDataSource;
  final FirebaseCrashlyticsAdapter _firebaseCrashlyticsDataSourceImpl;
  final FirebaseAnalyticsAdapter _firebaseAnalyticsDataSource;

  @override
  Future<void> error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) async {
    _loggerDataSource.error(message, error: error, stackTrace: stackTrace);
    _firebaseCrashlyticsDataSourceImpl.error(message,
        error: error, stackTrace: stackTrace);
    _firebaseAnalyticsDataSource.error(message,
        error: error, stackTrace: stackTrace);
  }

  @override
  Future<void> fatal(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) async {
    _loggerDataSource.fatal(message, error: error, stackTrace: stackTrace);
    _firebaseCrashlyticsDataSourceImpl.fatal(message,
        error: error, stackTrace: stackTrace);
    _firebaseAnalyticsDataSource.fatal(message,
        error: error, stackTrace: stackTrace);
  }

  @override
  Future<void> info(String message) async {
    _loggerDataSource.info(message);
    _firebaseCrashlyticsDataSourceImpl.info(message);
    _firebaseAnalyticsDataSource.info(message);
  }
}
