import '../../domain/repositories/log_repository.dart';
import '../data_sources/impl/firebase_crashlytics_data_source_impl.dart';
import '../data_sources/impl/logger_data_source_impl.dart';

class LogRepositoryImpl extends LogRepository {
  LogRepositoryImpl(
    this._loggerDataSource,
    this._firebaseCrashlyticsDataSourceImpl,
  );

  final LoggerDataSourceImpl _loggerDataSource;
  final FirebaseCrashlyticsDataSourceImpl _firebaseCrashlyticsDataSourceImpl;

  @override
  Future<void> error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) async {
    _loggerDataSource.error(message, error: error, stackTrace: stackTrace);
    _firebaseCrashlyticsDataSourceImpl.error(message,
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
  }

  @override
  Future<void> info(String message) async {
    _loggerDataSource.info(message);
    _firebaseCrashlyticsDataSourceImpl.info(message);
  }
}
