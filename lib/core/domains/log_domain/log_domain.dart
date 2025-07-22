import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogDomain {
  LogDomain._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
    ),
  );

  static void ensureInitialized() {
    Logger.level = kDebugMode ? Level.all : Level.error;
    Logger.addLogListener(
      (LogEvent event) {
        switch (event.level) {
          case Level.error:
          case Level.fatal:
            FirebaseCrashlytics.instance.recordError(
              Exception(event.message),
              event.stackTrace,
              reason: event.message,
              information: <Object>[
                'Time: ${event.time}',
              ],
              fatal: event.level == Level.fatal,
            );
            break;
          default:
            FirebaseCrashlytics.instance.log(
              '[${event.time}] <${event.level.name}> ${event.message}',
            );
        }
      },
    );
  }

  static void info(dynamic message) => _logger.i(message);

  static void error(dynamic message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  static void fatal(dynamic message, {Object? error, StackTrace? stackTrace}) =>
      _logger.f(message, error: error, stackTrace: stackTrace);
}
