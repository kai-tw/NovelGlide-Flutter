abstract class LogDataSource {
  Future<void> info(String message);
  Future<void> error(String message, {Object? error, StackTrace? stackTrace});
  Future<void> fatal(String message, {Object? error, StackTrace? stackTrace});
  Future<void> event(String name, {Map<String, Object>? parameters});
}
