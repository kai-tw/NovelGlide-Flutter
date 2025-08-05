import '../../main.dart';
import 'domain/repositories/log_repository.dart';

class LogSystem {
  LogSystem(this._repository);

  final LogRepository _repository;

  void _info(dynamic message) => _repository.info(message);

  void _error(dynamic message, {Object? error, StackTrace? stackTrace}) =>
      _repository.error(message, error: error, stackTrace: stackTrace);

  void _fatal(dynamic message, {Object? error, StackTrace? stackTrace}) =>
      _repository.fatal(message, error: error, stackTrace: stackTrace);

  /// Static members

  static void info(dynamic message) => sl<LogSystem>()._info(message);

  static void error(dynamic message, {Object? error, StackTrace? stackTrace}) =>
      sl<LogSystem>()._error(message, error: error, stackTrace: stackTrace);

  static void fatal(dynamic message, {Object? error, StackTrace? stackTrace}) =>
      sl<LogSystem>()._fatal(message, error: error, stackTrace: stackTrace);
}
