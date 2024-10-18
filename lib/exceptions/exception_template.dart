abstract class ExceptionTemplate implements Exception {
  abstract final String message;

  @override
  String toString() => '$runtimeType: $message';
}
