part 'backup_manager_pref.dart';
part 'reader_pref.dart';
part 'sort_order_pref.dart';
part 'tts_pref.dart';

class PreferenceKeys {
  PreferenceKeys._();

  static final backupManager = BackupManagerPref();
  static final reader = ReaderPref();
  static final bookshelf = SortOrderPref('bookshelf');
  static final collection = SortOrderPref('collection');
  static final bookmark = SortOrderPref('bookmark');
  static final tts = TtsPref();
}
