part 'backup_service_pref.dart';
part 'reader_pref.dart';
part 'sort_order_pref.dart';
part 'tts_pref.dart';

class PreferenceKeys {
  PreferenceKeys._();

  static final BackupServicePref backupService = BackupServicePref();
  static final ReaderPref reader = ReaderPref();
  static final SortOrderPref bookshelf = SortOrderPref('bookshelf');
  static final SortOrderPref collection = SortOrderPref('collection');
  static final SortOrderPref bookmark = SortOrderPref('bookmark');
  static final TtsPref tts = TtsPref();

  static const String userLocale = 'userLocale';
}
