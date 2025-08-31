abstract class LogRepository {
  Future<void> info(String message);

  Future<void> warn(String message);

  Future<void> error(String message, {Object? error, StackTrace? stackTrace});

  Future<void> fatal(String message, {Object? error, StackTrace? stackTrace});

  Future<void> event(String name, {Map<String, Object>? parameters});
}
