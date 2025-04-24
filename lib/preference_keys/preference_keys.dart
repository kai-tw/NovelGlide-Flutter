part 'backup_manager_pref.dart';
part 'reader_pref.dart';
part 'sort_order_pref.dart';
part 'tts_pref.dart';

class PreferenceKeys {
  PreferenceKeys._();

  static final BackupManagerPref backupManager = BackupManagerPref();
  static final ReaderPref reader = ReaderPref();
  static final SortOrderPref bookshelf = SortOrderPref('bookshelf');
  static final SortOrderPref collection = SortOrderPref('collection');
  static final SortOrderPref bookmark = SortOrderPref('bookmark');
  static final TtsPref tts = TtsPref();
}
