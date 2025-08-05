import 'package:logger/logger.dart';

import '../log_data_source.dart';

class LoggerAdapter extends LogDataSource {
  LoggerAdapter(this._logger);

  final Logger _logger;

  @override
  Future<void> error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) async {
    return _logger.e(message, error: error, stackTrace: stackTrace);
  }

  @override
  Future<void> fatal(String message,
      {Object? error, StackTrace? stackTrace}) async {
    return _logger.f(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  Future<void> info(String message) async {
    return _logger.i(message);
  }
}
