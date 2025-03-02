import 'backup_manager_pref.dart';
import 'reader_pref.dart';
import 'sort_order_pref.dart';
import 'tts_pref.dart';

class PreferenceKeys {
  PreferenceKeys._();

  static final backupManager = BackupManagerPref();
  static final reader = ReaderPref();
  static final bookshelf = SortOrderPref('bookshelf');
  static final collection = SortOrderPref('collection');
  static final bookmark = SortOrderPref('bookmark');
  static final tts = TtsPref();
}
