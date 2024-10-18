import 'exception_template.dart';

/// Exception thrown when a duplicate file is detected.
class DuplicateFileException extends ExceptionTemplate {
  @override
  final message =
      'A duplicate file has been detected. Please ensure the file is unique.';
}
