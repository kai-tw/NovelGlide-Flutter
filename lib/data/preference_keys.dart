/// A collection of preference keys used throughout the application.
class PreferenceKeys {
  PreferenceKeys._();

  static final BackupManagerPreferenceKeys backupManager =
      BackupManagerPreferenceKeys._();
  static final ReaderPreferenceKeys reader = ReaderPreferenceKeys._();
  static final ThemePreferenceKeys theme = ThemePreferenceKeys._();
  static final SortOrderPreferenceKeys bookshelf = SortOrderPreferenceKeys._();
  static final CollectionSortOrderPreferenceKeys collection =
      CollectionSortOrderPreferenceKeys._();
}

/// Preference keys related to backup management.
class BackupManagerPreferenceKeys {
  BackupManagerPreferenceKeys._();

  final String isBackupCollections = 'backupManager_isBackupCollections';
  final String isBackupBookmarks = 'backupManager_isBackupBookmarks';
}

/// Preference keys related to the reader settings.
class ReaderPreferenceKeys {
  ReaderPreferenceKeys._();

  final String fontSize = 'reader_fontSize';
  final String lineHeight = 'reader_lineHeight';
  final String autoSave = 'reader_autoSave';
  final String gestureDetection = 'reader_gestureDetection';
}

/// Preference keys related to theme settings.
class ThemePreferenceKeys {
  ThemePreferenceKeys._();

  final String themeId = 'theme_themeId';
  final String brightness = 'theme_brightness';
}

/// Preference keys related to sort order settings for bookshelf.
class SortOrderPreferenceKeys {
  SortOrderPreferenceKeys._();

  final String sortOrder = 'bookshelf_sortOrder';
  final String isAscending = 'bookshelf_isAscending';
}

/// Preference keys related to sort order settings for collection.
class CollectionSortOrderPreferenceKeys {
  CollectionSortOrderPreferenceKeys._();

  final String sortOrder = 'collection_sortOrder';
  final String isAscending = 'collection_isAscending';
}
