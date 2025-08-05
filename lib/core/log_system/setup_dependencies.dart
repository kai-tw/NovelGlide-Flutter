import 'package:logger/logger.dart';

import '../../main.dart';
import 'data/data_sources/adapters/firebase_analytics_adapter.dart';
import 'data/data_sources/adapters/firebase_crashlytics_adapter.dart';
import 'data/data_sources/adapters/logger_adapter.dart';
import 'data/repositories/log_repository_impl.dart';
import 'domain/repositories/log_repository.dart';
import 'log_system.dart';

void setupLogDependencies() {
  // Register Logger for console logging.
  final Logger logger = Logger();
  sl.registerLazySingleton<LoggerAdapter>(
    () => LoggerAdapter(logger),
  );

  // Register FirebaseCrashlytics.
  sl.registerLazySingleton<FirebaseCrashlyticsAdapter>(
    () => FirebaseCrashlyticsAdapter(),
  );

  // Register FirebaseCrashlytics.
  sl.registerLazySingleton<FirebaseAnalyticsAdapter>(
    () => FirebaseAnalyticsAdapter(),
  );

  // Register LogRepository
  sl.registerLazySingleton<LogRepository>(
    () => LogRepositoryImpl(
      sl<LoggerAdapter>(),
      sl<FirebaseCrashlyticsAdapter>(),
      sl<FirebaseAnalyticsAdapter>(),
    ),
  );

  // Register LogSystem
  sl.registerLazySingleton<LogSystem>(
    () => LogSystem(sl<LogRepository>()),
  );
}
