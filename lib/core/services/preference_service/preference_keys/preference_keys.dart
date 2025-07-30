part of '../preference_service.dart';

class PreferenceKeys {
  PreferenceKeys._();

  static final BackupServicePref backupService = BackupServicePref();
  static final ReaderPref reader = ReaderPref();
  static final SharedListPrefs bookshelf = SharedListPrefs('bookshelf');
  static final SharedListPrefs collection = SharedListPrefs('collection');
  static final SharedListPrefs bookmark = SharedListPrefs('bookmark');
  static final TtsPref tts = TtsPref();

  static const String userLocale = 'userLocale';
  static const String themeMode = 'themeMode';
}
