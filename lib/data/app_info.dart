import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static final AppInfo instance = _instance;
  static final AppInfo _instance = AppInfo._init();

  late final String appName;
  late final String packageName;
  late final String version;
  late final String buildNumber;
  String get appVersion => "${Platform.operatingSystem} v$version";

  factory AppInfo() => _instance;
  AppInfo._init();

  Future<void> init() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }
}