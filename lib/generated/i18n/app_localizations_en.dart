// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get generalEmpty => 'There\'s nothing.';

  @override
  String get generalLoading => 'Loading';

  @override
  String get generalSubmit => 'Submit';

  @override
  String get generalSelect => 'Select';

  @override
  String get generalDelete => 'Delete';

  @override
  String get generalCancel => 'Cancel';

  @override
  String get generalClose => 'Close';

  @override
  String get generalYes => 'Yes';

  @override
  String get generalNo => 'No';

  @override
  String get generalSave => 'Save';

  @override
  String get generalDone => 'Done';

  @override
  String get generalSelectAll => 'Select all';

  @override
  String get generalDeselectAll => 'Deselect all';

  @override
  String get generalDragHereToDelete => 'Drag here to delete it';

  @override
  String get generalAdd => 'Add';

  @override
  String get generalName => 'Name';

  @override
  String get generalReset => 'Reset';

  @override
  String get generalRefreshAndTryAgain => 'Please refresh and try again.';

  @override
  String get bookshelfTitle => 'Bookshelf';

  @override
  String get bookshelfSortName => 'Book Name';

  @override
  String get bookshelfSortLastModified => 'Adding Time';

  @override
  String get bookshelfNoBook => 'There is no book';

  @override
  String get bookshelfBookNotExist => 'This book doesn\'t exist';

  @override
  String get bookshelfAccessibilityCheckbox => 'Tap to select or deselect this book.';

  @override
  String get deleteBookSuccessfully => 'Successfully delete the book';

  @override
  String get deleteBookFailed => 'Failed to delete the book';

  @override
  String get addBookFailed => 'Failed to add the book';

  @override
  String get addBookDuplicated => 'The book has already existed.';

  @override
  String get addToCollection => 'Add to Collections';

  @override
  String get collectionTitle => 'Collection';

  @override
  String get collectionNoCollection => 'There\'s no collection';

  @override
  String get collectionAddBtn => 'Add a collection';

  @override
  String get collectionAddTitle => 'Add a collection';

  @override
  String get collectionName => 'Collection Name';

  @override
  String get collectionAddSuccess => 'The collection was added successfully.';

  @override
  String collectionDelete(Object number) {
    return 'Delete $number selected collections.';
  }

  @override
  String get collectionAddToCollections => 'Add to collections';

  @override
  String get collectionSaved => 'Collection Saved.';

  @override
  String get collectionAddEmpty => 'It cannot be empty.';

  @override
  String get bookmarkListTitle => 'Bookmarks';

  @override
  String get bookmarkListNoBookmark => 'There is no saved bookmark';

  @override
  String get bookmarkListSortName => 'Bookmark Name';

  @override
  String get bookmarkListSortSavedTime => 'Saved Time';

  @override
  String bookmarkListDeleteNumberOfSelectedBookmarks(Object number) {
    return 'Delete $number selected bookmarks';
  }

  @override
  String get bookmarkListAccessibilitySelectItem => 'Select or unselect the bookmark';

  @override
  String get bookmarkListAccessibilityItem => 'A bookmark';

  @override
  String get bookmarkListAccessibilityOnTap => 'Tap to continue reading from the bookmark';

  @override
  String get bookmarkListAccessibilityOnLongPress => 'Long press and drag to delete the bookmark';

  @override
  String get bookmarkListAccessibilitySelectOnTap => 'Tap to select or deselect this bookmark';

  @override
  String savedTimeFunction(Object part) {
    return 'Saved in $part.';
  }

  @override
  String get savedTimeToday => 'Today';

  @override
  String get savedTimeYesterday => 'Yesterday';

  @override
  String savedTimeOthersFunction(Object days) {
    return '$days days before';
  }

  @override
  String get deleteBookmarkSuccessfully => 'Successfully delete the bookmark';

  @override
  String get tocContinueReading => 'Continue Reading';

  @override
  String get tocStartReading => 'Start Reading';

  @override
  String get tocNoChapter => 'There is no chapter';

  @override
  String get readerLoadingInitialize => 'Initializing';

  @override
  String get readerLoadingBookLoading => 'Loading the book';

  @override
  String get readerLoadingRendering => 'Rendering';

  @override
  String get readerSettingsResetButton => 'Reset settings';

  @override
  String get readerSettingsResetButtonDone => 'Reset done';

  @override
  String get readerSettingsAutoSaveSwitch => 'Automatically save a bookmark';

  @override
  String get readerSettingsGesture => 'Gesture of flipping page';

  @override
  String get readerSettingsFlippingAnime => 'Animation of flipping page';

  @override
  String get readerSettingsPageNumTypeLabel => 'The display method of page number';

  @override
  String get readerSettingsPageNumTypeHelperText => 'Choose the display method of the page number';

  @override
  String get readerSettingsPageNumTypeHidden => 'Hidden';

  @override
  String get readerSettingsPageNumTypeNumber => 'Number of pages';

  @override
  String get readerSettingsPageNumTypePercentage => 'Percentage';

  @override
  String get readerSettingsPageNumTypeProgressBar => 'Progress bar';

  @override
  String get readerSearch => 'Search';

  @override
  String get readerSearchCurrentChapter => 'Chapter';

  @override
  String get readerSearchAllRange => 'All';

  @override
  String get readerSearchTypeToSearch => 'Type to Search';

  @override
  String get readerSearchNoResult => 'No Result';

  @override
  String readerSearchResultCount(Object number) {
    return 'Total $number results';
  }

  @override
  String get readerSearchCopyExcerpt => 'Copy excerpt';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsPageAbout => 'About';

  @override
  String get settingsFeedback => 'Feedback';

  @override
  String get backupManagerTitle => 'Backup';

  @override
  String get backupManagerFileManagement => 'Backup File Management';

  @override
  String get backupManagerLabelAll => 'All';

  @override
  String get backupManagerLabelLibrary => 'Bookshelf';

  @override
  String get backupManagerLabelCollection => 'Collections';

  @override
  String get backupManagerLabelBookmark => 'Bookmarks';

  @override
  String get backupManagerBackupAll => 'Backup all now';

  @override
  String get backupManagerBackupLibrary => 'Backup All Books';

  @override
  String get backupManagerBackupCollection => 'Backup Collections';

  @override
  String get backupManagerBackupBookmark => 'Backup Bookmarks';

  @override
  String get backupManagerBackupSuccessfully => 'Backup successfully';

  @override
  String get backupManagerBackupFailed => 'Backup unsuccessfully';

  @override
  String get backupManagerRestoreAll => 'Restore all';

  @override
  String get backupManagerRestoreLibrary => 'Restore all books';

  @override
  String get backupManagerRestoreCollection => 'Restore Collections';

  @override
  String get backupManagerRestoreBookmark => 'Restore Bookmarks';

  @override
  String get backupManagerRestoreSuccessfully => 'Restore successfully';

  @override
  String get backupManagerRestoreFailed => 'Restore unsuccessfully';

  @override
  String get backupManagerDeleteAllBackup => 'Delete all backups';

  @override
  String get backupManagerDeleteLibraryBackup => 'Delete the backup of all books';

  @override
  String get backupManagerDeleteCollectionBackup => 'Delete the backup of collections';

  @override
  String get backupManagerDeleteBookmarkBackup => 'Delete the backup of bookmarks';

  @override
  String get backupManagerDeleteBackupSuccessfully => 'Successfully delete backup';

  @override
  String get backupManagerDeleteBackupFailed => 'Unsuccessfully delete backup';

  @override
  String get backupManagerLastTime => 'Last backup time';

  @override
  String get backupManagerGoogleDrive => 'Google Drive';

  @override
  String get resetPageTitle => 'Reset';

  @override
  String get resetPageDataTitle => 'Data';

  @override
  String get resetPageDeleteAllBooks => 'Delete all books';

  @override
  String get resetPageDeleteAllBookmarks => 'Delete all bookmarks';

  @override
  String get resetPageDeleteAllCollections => 'Delete all collections';

  @override
  String get resetPageCacheTitle => 'Cache';

  @override
  String get resetPageCacheClear => 'Clear all caches';

  @override
  String get resetPagePreferenceTitle => 'Preference';

  @override
  String get resetPageResetPreference => 'Reset all preferences';

  @override
  String get resetPageResetThemeManager => 'Reset the theme settings';

  @override
  String get resetPageResetBackupManager => 'Reset the backup settings';

  @override
  String get resetPageResetBookshelf => 'Reset the bookshelf settings';

  @override
  String get resetPageResetCollectionList => 'Reset the collections list settings';

  @override
  String get resetPageResetBookmarkList => 'Reset the bookmark list settings';

  @override
  String get resetPageResetReader => 'Reset the reader settings';

  @override
  String get ttsSettingsTitle => 'Text-to-Speech Settings';

  @override
  String get ttsSettingsPlay => 'Play';

  @override
  String get ttsSettingsPause => 'Pause';

  @override
  String get ttsSettingsStop => 'Stop';

  @override
  String get ttsSettingsReset => 'Reset';

  @override
  String get ttsSettingsPitch => 'Pitch';

  @override
  String get ttsSettingsVolume => 'Volume';

  @override
  String get ttsSettingsSpeechRate => 'Speech rate';

  @override
  String get ttsSettingsTypeHere => 'Type some text here';

  @override
  String get languageCodeSqAL => 'Albanian (Albania)';

  @override
  String get languageCodeAr => 'Arabic';

  @override
  String get languageCodeAsIN => 'Assamese (India)';

  @override
  String get languageCodeBnBD => 'Bengali (Bangladesh)';

  @override
  String get languageCodeBnIN => 'Bengali (India)';

  @override
  String get languageCodeBrxIN => 'Bodo (India)';

  @override
  String get languageCodeBsBA => 'Bosnian (Bosnia and Herzegovina)';

  @override
  String get languageCodeBgBG => 'Bulgarian (Bulgaria)';

  @override
  String get languageCodeYueHK => 'Cantonese (Hong Kong)';

  @override
  String get languageCodeCaES => 'Catalan (Spain)';

  @override
  String get languageCodeZhCN => 'Chinese (Simplified, China)';

  @override
  String get languageCodeZhTW => 'Chinese (Traditional, Taiwan)';

  @override
  String get languageCodeHrHR => 'Croatian (Croatia)';

  @override
  String get languageCodeCsCZ => 'Czech (Czech Republic)';

  @override
  String get languageCodeDaDK => 'Danish (Denmark)';

  @override
  String get languageCodeDoiIN => 'Dogri (India)';

  @override
  String get languageCodeNlBE => 'Dutch (Belgium)';

  @override
  String get languageCodeNlNL => 'Dutch (Netherlands)';

  @override
  String get languageCodeEnAU => 'English (Australia)';

  @override
  String get languageCodeEnIN => 'English (India)';

  @override
  String get languageCodeEnNG => 'English (Nigeria)';

  @override
  String get languageCodeEnGB => 'English (United Kingdom)';

  @override
  String get languageCodeEnUS => 'English (United States)';

  @override
  String get languageCodeEtEE => 'Estonian (Estonia)';

  @override
  String get languageCodeFilPH => 'Filipino (Philippines)';

  @override
  String get languageCodeFiFI => 'Finnish (Finland)';

  @override
  String get languageCodeFrCA => 'French (Canada)';

  @override
  String get languageCodeFrFR => 'French (France)';

  @override
  String get languageCodeDeDE => 'German (Germany)';

  @override
  String get languageCodeElGR => 'Greek (Greece)';

  @override
  String get languageCodeGuIN => 'Gujarati (India)';

  @override
  String get languageCodeHeIL => 'Hebrew (Israel)';

  @override
  String get languageCodeHiIN => 'Hindi (India)';

  @override
  String get languageCodeHuHU => 'Hungarian (Hungary)';

  @override
  String get languageCodeIsIS => 'Icelandic (Iceland)';

  @override
  String get languageCodeIdID => 'Indonesian (Indonesia)';

  @override
  String get languageCodeItIT => 'Italian (Italy)';

  @override
  String get languageCodeJaJP => 'Japanese (Japan)';

  @override
  String get languageCodeJvID => 'Javanese (Indonesia)';

  @override
  String get languageCodeKnIN => 'Kannada (India)';

  @override
  String get languageCodeKsIN => 'Kashmiri (India)';

  @override
  String get languageCodeKmKH => 'Khmer (Cambodia)';

  @override
  String get languageCodeKokIN => 'Konkani (India)';

  @override
  String get languageCodeKoKR => 'Korean (South Korea)';

  @override
  String get languageCodeLvLV => 'Latvian (Latvia)';

  @override
  String get languageCodeLtLT => 'Lithuanian (Lithuania)';

  @override
  String get languageCodeMaiIN => 'Maithili (India)';

  @override
  String get languageCodeMsMY => 'Malay (Malaysia)';

  @override
  String get languageCodeMlIN => 'Malayalam (India)';

  @override
  String get languageCodeMniIN => 'Manipuri (Meitei, India)';

  @override
  String get languageCodeMrIN => 'Marathi (India)';

  @override
  String get languageCodeNeNP => 'Nepali (Nepal)';

  @override
  String get languageCodeNbNO => 'Norwegian Bokmål (Norway)';

  @override
  String get languageCodeOrIN => 'Odia (Oriya, India)';

  @override
  String get languageCodePlPL => 'Polish (Poland)';

  @override
  String get languageCodePtBR => 'Portuguese (Brazil)';

  @override
  String get languageCodePtPT => 'Portuguese (Portugal)';

  @override
  String get languageCodePaIN => 'Punjabi (India)';

  @override
  String get languageCodeRoRO => 'Romanian (Romania)';

  @override
  String get languageCodeRuRU => 'Russian (Russia)';

  @override
  String get languageCodeSaIN => 'Sanskrit (India)';

  @override
  String get languageCodeSatIN => 'Santali (India)';

  @override
  String get languageCodeSrRS => 'Serbian (Serbia)';

  @override
  String get languageCodeSdIN => 'Sindhi (India)';

  @override
  String get languageCodeSiLK => 'Sinhala (Sri Lanka)';

  @override
  String get languageCodeSkSK => 'Slovak (Slovakia)';

  @override
  String get languageCodeSlSI => 'Slovenian (Slovenia)';

  @override
  String get languageCodeEsES => 'Spanish (Spain)';

  @override
  String get languageCodeEsUS => 'Spanish (United States)';

  @override
  String get languageCodeSuID => 'Sundanese (Indonesia)';

  @override
  String get languageCodeSwKE => 'Swahili (Kenya)';

  @override
  String get languageCodeSvSE => 'Swedish (Sweden)';

  @override
  String get languageCodeTaIN => 'Tamil (India)';

  @override
  String get languageCodeTeIN => 'Telugu (India)';

  @override
  String get languageCodeThTH => 'Thai (Thailand)';

  @override
  String get languageCodeTrTR => 'Turkish (Turkey)';

  @override
  String get languageCodeUkUA => 'Ukrainian (Ukraine)';

  @override
  String get languageCodeUrIN => 'Urdu (India)';

  @override
  String get languageCodeUrPK => 'Urdu (Pakistan)';

  @override
  String get languageCodeViVN => 'Vietnamese (Vietnam)';

  @override
  String get languageCodeCyGB => 'Welsh (United Kingdom)';

  @override
  String languageCodeUnknown(Object code) {
    return 'Unknown language: \$$code';
  }

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get fileEmpty => 'No file selected';

  @override
  String get fileTypeHelperText => 'Only accept these type of files:';

  @override
  String get fileSystemUntitledFile => 'Untitled File';

  @override
  String fileSystemCreateOnDate(Object datetime) {
    return 'Create on $datetime';
  }

  @override
  String get fileSystemPermissionDenied => 'Permission Denied';

  @override
  String get dialogDeleteTitle => 'Are you sure?';

  @override
  String get dialogDeleteContent => 'You will not be able to restore them.';

  @override
  String get alertDialogResetSettingsTitle => 'Reset settings';

  @override
  String get alertDialogResetSettingsDescription => 'Are you sure to reset settings?';

  @override
  String get accessibilityBackButton => 'Go back';

  @override
  String get accessibilityAddBookButton => 'Add a book';

  @override
  String accessibilityThemeSelectionButton(Object name) {
    return 'Use $name theme';
  }

  @override
  String get accessibilityAppIcon => 'NovelGlide icon';

  @override
  String get accessibilityBookCover => 'The book cover';

  @override
  String get accessibilityBookshelfListItem => 'A book';

  @override
  String get accessibilityBookshelfListItemOnTap => 'Tap to open this book';

  @override
  String get accessibilityBookshelfListItemOnLongPress => 'Long press and drag to delete the book';

  @override
  String get accessibilityReaderPrevChapterButton => 'Previous chapter';

  @override
  String get accessibilityReaderNextChapterButton => 'Next chapter';

  @override
  String get accessibilityReaderBookmarkButton => 'Jump to the bookmark';

  @override
  String get accessibilityReaderAddBookmarkButton => 'Add a bookmark';

  @override
  String get accessibilityReaderSettingsButton => 'Reader settings';

  @override
  String get accessibilityFontSizeSliderMinIcon => 'Minimum font size';

  @override
  String get accessibilityFontSizeSliderMaxIcon => 'Maximum font size';

  @override
  String get accessibilityFontSizeSlider => 'Font size slider';

  @override
  String get accessibilityLineHeightSliderMinIcon => 'Minimum line height';

  @override
  String get accessibilityLineHeightSliderMaxIcon => 'Maximum line height';

  @override
  String get accessibilityLineHeightSlider => 'Line height slider';

  @override
  String get exceptionUnknownError => 'Unknown Error Occurred';
}
