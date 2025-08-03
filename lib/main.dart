import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app/app.dart';
import 'core/services/log_service/log_service.dart';
import 'core/setup_dependencies.dart';
import 'firebase_options.dart';

final GetIt sl = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup dependencies
  await setupDependencies();
  sl.allReadySync();

  // Firebase initializations
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Log Initialization
  LogService.ensureInitialized();

  // Start App
  FirebaseAnalytics.instance.logAppOpen();
  runApp(const App());
}
