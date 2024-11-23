/// A collection of preference keys used throughout the application.
class PreferenceKeys {
  PreferenceKeys._();

  static final BackupManagerPref backupManager = BackupManagerPref._();
  static final ReaderPref reader = ReaderPref._();
  static final ThemePref theme = ThemePref._();
  static final SortOrderPref bookshelf = SortOrderPref._('bookshelf');
  static final SortOrderPref collection = SortOrderPref._('collection');
  static final SortOrderPref bookmark = SortOrderPref._('bookmark');
}

/// Preference keys related to backup management.
class BackupManagerPref {
  BackupManagerPref._();

  final String isGoogleDriveEnabled = 'backupManager.isBackupToGoogleDrive';
}

/// Preference keys related to the reader settings.
class ReaderPref {
  ReaderPref._();

  final String fontSize = 'reader.fontSize';
  final String lineHeight = 'reader.lineHeight';
  final String autoSave = 'reader.autoSave';
  final String gestureDetection = 'reader.gestureDetection';
  final String isSmoothScroll = 'reader.isSmoothScroll';
  final String pageNumType = 'reader.pageNumType';
}

/// Preference keys related to theme settings.
class ThemePref {
  ThemePref._();

  final String themeId = 'theme.themeId';
  final String brightness = 'theme.brightness';
}

/// Preference keys related to sort order settings.
class SortOrderPref {
  final String sortOrder;
  final String isAscending;

  factory SortOrderPref._(String prefix) =>
      SortOrderPref._internal('$prefix.sortOrder', '$prefix.isAscending');

  SortOrderPref._internal(this.sortOrder, this.isAscending);
}
