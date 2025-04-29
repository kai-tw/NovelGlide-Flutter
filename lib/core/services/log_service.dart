import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogService {
  LogService._();

  static void ensureInitialized() {
    Logger.level = kDebugMode ? Level.all : Level.off;
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
}
