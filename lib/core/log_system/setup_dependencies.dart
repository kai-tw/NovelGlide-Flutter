import 'package:logger/logger.dart';

import '../../main.dart';
import 'data/data_sources/impl/firebase_analytics_data_source_impl.dart';
import 'data/data_sources/impl/firebase_crashlytics_data_source_impl.dart';
import 'data/data_sources/impl/logger_data_source_impl.dart';
import 'data/repositories/log_repository_impl.dart';
import 'domain/repositories/log_repository.dart';
import 'log_system.dart';

void setupLogDependencies() {
  // Register Logger for console logging.
  final Logger logger = Logger();
  sl.registerLazySingleton<LoggerDataSourceImpl>(
    () => LoggerDataSourceImpl(logger),
  );

  // Register FirebaseCrashlytics.
  sl.registerLazySingleton<FirebaseCrashlyticsDataSourceImpl>(
    () => FirebaseCrashlyticsDataSourceImpl(),
  );

  // Register FirebaseCrashlytics.
  sl.registerLazySingleton<FirebaseAnalyticsDataSourceImpl>(
    () => FirebaseAnalyticsDataSourceImpl(),
  );

  // Register LogRepository
  sl.registerLazySingleton<LogRepository>(
    () => LogRepositoryImpl(
      sl<LoggerDataSourceImpl>(),
      sl<FirebaseCrashlyticsDataSourceImpl>(),
      sl<FirebaseAnalyticsDataSourceImpl>(),
    ),
  );

  // Register LogSystem
  sl.registerLazySingleton<LogSystem>(
    () => LogSystem(sl<LogRepository>()),
  );
}
