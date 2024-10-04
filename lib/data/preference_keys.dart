class PreferenceKeys {
  PreferenceKeys._();

  static final BackupManagerPreferenceKeys backupManager = BackupManagerPreferenceKeys._();
  static final ReaderPreferenceKeys reader = ReaderPreferenceKeys._();
  static final ThemePreferenceKeys theme = ThemePreferenceKeys._();
  static final SortOrderPreferenceKeys bookshelf = SortOrderPreferenceKeys._();
  static final SortOrderPreferenceKeys collection = SortOrderPreferenceKeys._();
}

class BackupManagerPreferenceKeys {
  BackupManagerPreferenceKeys._();

  final String isBackupCollections = 'isBackupCollections';
  final String isBackupBookmarks = 'isBackupBookmarks';
}

class ReaderPreferenceKeys {
  ReaderPreferenceKeys._();

  final String fontSize = 'fontSize';
  final String lineHeight = 'lineHeight';
  final String autoSave = 'autoSave';
  final String gestureDetection = 'gestureDetection';
}

class ThemePreferenceKeys {
  ThemePreferenceKeys._();

  final String themeId = 'themeId';
  final String brightness = 'brightness';
}

class SortOrderPreferenceKeys {
  SortOrderPreferenceKeys._();

  final String sortOrder = 'sortOrder';
  final String isAscending = 'isAscending';
}