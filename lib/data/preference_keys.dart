/// A collection of preference keys used throughout the application.
class PreferenceKeys {
  PreferenceKeys._();

  static final BackupManagerPref backupManager = BackupManagerPref._();
  static final ReaderPref reader = ReaderPref._();
  static final ThemePref theme = ThemePref._();
  static final SortOrderPref bookshelf = SortOrderPref._();
  static final CollectionSortOrderPref collection = CollectionSortOrderPref._();
}

/// Preference keys related to backup management.
class BackupManagerPref {
  BackupManagerPref._();

  final String isBackupCollections = 'backupManager_isBackupCollections';
  final String isBackupBookmarks = 'backupManager_isBackupBookmarks';
  final String isGoogleDriveEnabled = 'backupManager_isBackupToGoogleDrive';
}

/// Preference keys related to the reader settings.
class ReaderPref {
  ReaderPref._();

  final String fontSize = 'reader_fontSize';
  final String lineHeight = 'reader_lineHeight';
  final String autoSave = 'reader_autoSave';
  final String gestureDetection = 'reader_gestureDetection';
}

/// Preference keys related to theme settings.
class ThemePref {
  ThemePref._();

  final String themeId = 'theme_themeId';
  final String brightness = 'theme_brightness';
}

/// Preference keys related to sort order settings for bookshelf.
class SortOrderPref {
  SortOrderPref._();

  final String sortOrder = 'bookshelf_sortOrder';
  final String isAscending = 'bookshelf_isAscending';
}

/// Preference keys related to sort order settings for collection.
class CollectionSortOrderPref {
  CollectionSortOrderPref._();

  final String sortOrder = 'collection_sortOrder';
  final String isAscending = 'collection_isAscending';
}
