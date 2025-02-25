import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN', scriptCode: 'Hans')
  ];

  /// No description provided for @generalEmpty.
  ///
  /// In en, this message translates to:
  /// **'There\'s nothing.'**
  String get generalEmpty;

  /// No description provided for @generalLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get generalLoading;

  /// No description provided for @generalSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get generalSubmit;

  /// No description provided for @generalSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get generalSelect;

  /// No description provided for @generalDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get generalDelete;

  /// No description provided for @generalCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get generalCancel;

  /// No description provided for @generalClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get generalClose;

  /// No description provided for @generalYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get generalYes;

  /// No description provided for @generalNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get generalNo;

  /// No description provided for @generalSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get generalSave;

  /// No description provided for @generalDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get generalDone;

  /// No description provided for @generalSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get generalSelectAll;

  /// No description provided for @generalDeselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect all'**
  String get generalDeselectAll;

  /// No description provided for @generalDragHereToDelete.
  ///
  /// In en, this message translates to:
  /// **'Drag here to delete it'**
  String get generalDragHereToDelete;

  /// No description provided for @generalAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get generalAdd;

  /// No description provided for @generalName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get generalName;

  /// No description provided for @generalReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get generalReset;

  /// No description provided for @generalRefreshAndTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Please refresh and try again.'**
  String get generalRefreshAndTryAgain;

  /// No description provided for @bookshelfTitle.
  ///
  /// In en, this message translates to:
  /// **'Bookshelf'**
  String get bookshelfTitle;

  /// No description provided for @bookshelfSortName.
  ///
  /// In en, this message translates to:
  /// **'Book Name'**
  String get bookshelfSortName;

  /// No description provided for @bookshelfSortLastModified.
  ///
  /// In en, this message translates to:
  /// **'Adding Time'**
  String get bookshelfSortLastModified;

  /// No description provided for @bookshelfNoBook.
  ///
  /// In en, this message translates to:
  /// **'There is no book'**
  String get bookshelfNoBook;

  /// No description provided for @bookshelfBookNotExist.
  ///
  /// In en, this message translates to:
  /// **'This book doesn\'t exist'**
  String get bookshelfBookNotExist;

  /// No description provided for @bookshelfAccessibilityCheckbox.
  ///
  /// In en, this message translates to:
  /// **'Tap to select or deselect this book.'**
  String get bookshelfAccessibilityCheckbox;

  /// No description provided for @deleteBookSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully delete the book'**
  String get deleteBookSuccessfully;

  /// No description provided for @deleteBookFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete the book'**
  String get deleteBookFailed;

  /// No description provided for @addBookFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add the book'**
  String get addBookFailed;

  /// No description provided for @addBookDuplicated.
  ///
  /// In en, this message translates to:
  /// **'The book has already existed.'**
  String get addBookDuplicated;

  /// No description provided for @addToCollection.
  ///
  /// In en, this message translates to:
  /// **'Add to Collections'**
  String get addToCollection;

  /// No description provided for @collectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get collectionTitle;

  /// No description provided for @collectionNoCollection.
  ///
  /// In en, this message translates to:
  /// **'There\'s no collection'**
  String get collectionNoCollection;

  /// No description provided for @collectionAddBtn.
  ///
  /// In en, this message translates to:
  /// **'Add a collection'**
  String get collectionAddBtn;

  /// No description provided for @collectionAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a collection'**
  String get collectionAddTitle;

  /// No description provided for @collectionName.
  ///
  /// In en, this message translates to:
  /// **'Collection Name'**
  String get collectionName;

  /// No description provided for @collectionAddSuccess.
  ///
  /// In en, this message translates to:
  /// **'The collection was added successfully.'**
  String get collectionAddSuccess;

  /// No description provided for @collectionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete {number} selected collections.'**
  String collectionDelete(Object number);

  /// No description provided for @collectionAddToCollections.
  ///
  /// In en, this message translates to:
  /// **'Add to collections'**
  String get collectionAddToCollections;

  /// No description provided for @collectionSaved.
  ///
  /// In en, this message translates to:
  /// **'Collection Saved.'**
  String get collectionSaved;

  /// No description provided for @collectionAddEmpty.
  ///
  /// In en, this message translates to:
  /// **'It cannot be empty.'**
  String get collectionAddEmpty;

  /// No description provided for @bookmarkListTitle.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarkListTitle;

  /// No description provided for @bookmarkListNoBookmark.
  ///
  /// In en, this message translates to:
  /// **'There is no saved bookmark'**
  String get bookmarkListNoBookmark;

  /// No description provided for @bookmarkListSortName.
  ///
  /// In en, this message translates to:
  /// **'Bookmark Name'**
  String get bookmarkListSortName;

  /// No description provided for @bookmarkListSortSavedTime.
  ///
  /// In en, this message translates to:
  /// **'Saved Time'**
  String get bookmarkListSortSavedTime;

  /// No description provided for @bookmarkListDeleteNumberOfSelectedBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Delete {number} selected bookmarks'**
  String bookmarkListDeleteNumberOfSelectedBookmarks(Object number);

  /// No description provided for @bookmarkListAccessibilitySelectItem.
  ///
  /// In en, this message translates to:
  /// **'Select or unselect the bookmark'**
  String get bookmarkListAccessibilitySelectItem;

  /// No description provided for @bookmarkListAccessibilityItem.
  ///
  /// In en, this message translates to:
  /// **'A bookmark'**
  String get bookmarkListAccessibilityItem;

  /// No description provided for @bookmarkListAccessibilityOnTap.
  ///
  /// In en, this message translates to:
  /// **'Tap to continue reading from the bookmark'**
  String get bookmarkListAccessibilityOnTap;

  /// No description provided for @bookmarkListAccessibilityOnLongPress.
  ///
  /// In en, this message translates to:
  /// **'Long press and drag to delete the bookmark'**
  String get bookmarkListAccessibilityOnLongPress;

  /// No description provided for @bookmarkListAccessibilitySelectOnTap.
  ///
  /// In en, this message translates to:
  /// **'Tap to select or deselect this bookmark'**
  String get bookmarkListAccessibilitySelectOnTap;

  /// No description provided for @savedTimeFunction.
  ///
  /// In en, this message translates to:
  /// **'Saved in {part}.'**
  String savedTimeFunction(Object part);

  /// No description provided for @savedTimeToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get savedTimeToday;

  /// No description provided for @savedTimeYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get savedTimeYesterday;

  /// No description provided for @savedTimeOthersFunction.
  ///
  /// In en, this message translates to:
  /// **'{days} days before'**
  String savedTimeOthersFunction(Object days);

  /// No description provided for @deleteBookmarkSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully delete the bookmark'**
  String get deleteBookmarkSuccessfully;

  /// No description provided for @tocContinueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue Reading'**
  String get tocContinueReading;

  /// No description provided for @tocStartReading.
  ///
  /// In en, this message translates to:
  /// **'Start Reading'**
  String get tocStartReading;

  /// No description provided for @tocNoChapter.
  ///
  /// In en, this message translates to:
  /// **'There is no chapter'**
  String get tocNoChapter;

  /// No description provided for @readerLoadingInitialize.
  ///
  /// In en, this message translates to:
  /// **'Initializing'**
  String get readerLoadingInitialize;

  /// No description provided for @readerLoadingBookLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading the book'**
  String get readerLoadingBookLoading;

  /// No description provided for @readerLoadingRendering.
  ///
  /// In en, this message translates to:
  /// **'Rendering'**
  String get readerLoadingRendering;

  /// No description provided for @readerSettingsResetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset settings'**
  String get readerSettingsResetButton;

  /// No description provided for @readerSettingsResetButtonDone.
  ///
  /// In en, this message translates to:
  /// **'Reset done'**
  String get readerSettingsResetButtonDone;

  /// No description provided for @readerSettingsAutoSaveSwitch.
  ///
  /// In en, this message translates to:
  /// **'Automatically save a bookmark'**
  String get readerSettingsAutoSaveSwitch;

  /// No description provided for @readerSettingsGesture.
  ///
  /// In en, this message translates to:
  /// **'Gesture of flipping page'**
  String get readerSettingsGesture;

  /// No description provided for @readerSettingsFlippingAnime.
  ///
  /// In en, this message translates to:
  /// **'Animation of flipping page'**
  String get readerSettingsFlippingAnime;

  /// No description provided for @readerSettingsPageNumTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'The display method of page number'**
  String get readerSettingsPageNumTypeLabel;

  /// No description provided for @readerSettingsPageNumTypeHelperText.
  ///
  /// In en, this message translates to:
  /// **'Choose the display method of the page number'**
  String get readerSettingsPageNumTypeHelperText;

  /// No description provided for @readerSettingsPageNumTypeHidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get readerSettingsPageNumTypeHidden;

  /// No description provided for @readerSettingsPageNumTypeNumber.
  ///
  /// In en, this message translates to:
  /// **'Number of pages'**
  String get readerSettingsPageNumTypeNumber;

  /// No description provided for @readerSettingsPageNumTypePercentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get readerSettingsPageNumTypePercentage;

  /// No description provided for @readerSettingsPageNumTypeProgressBar.
  ///
  /// In en, this message translates to:
  /// **'Progress bar'**
  String get readerSettingsPageNumTypeProgressBar;

  /// No description provided for @readerSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get readerSearch;

  /// No description provided for @readerSearchCurrentChapter.
  ///
  /// In en, this message translates to:
  /// **'Chapter'**
  String get readerSearchCurrentChapter;

  /// No description provided for @readerSearchAllRange.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get readerSearchAllRange;

  /// No description provided for @readerSearchTypeToSearch.
  ///
  /// In en, this message translates to:
  /// **'Type to Search'**
  String get readerSearchTypeToSearch;

  /// No description provided for @readerSearchNoResult.
  ///
  /// In en, this message translates to:
  /// **'No Result'**
  String get readerSearchNoResult;

  /// No description provided for @readerSearchResultCount.
  ///
  /// In en, this message translates to:
  /// **'Total {number} results'**
  String readerSearchResultCount(Object number);

  /// No description provided for @readerSearchCopyExcerpt.
  ///
  /// In en, this message translates to:
  /// **'Copy excerpt'**
  String get readerSearchCopyExcerpt;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsPageAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsPageAbout;

  /// No description provided for @settingsFeedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get settingsFeedback;

  /// No description provided for @backupManagerTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backupManagerTitle;

  /// No description provided for @backupManagerFileManagement.
  ///
  /// In en, this message translates to:
  /// **'Backup File Management'**
  String get backupManagerFileManagement;

  /// No description provided for @backupManagerLabelAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get backupManagerLabelAll;

  /// No description provided for @backupManagerLabelLibrary.
  ///
  /// In en, this message translates to:
  /// **'Bookshelf'**
  String get backupManagerLabelLibrary;

  /// No description provided for @backupManagerLabelCollection.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get backupManagerLabelCollection;

  /// No description provided for @backupManagerLabelBookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get backupManagerLabelBookmark;

  /// No description provided for @backupManagerBackupAll.
  ///
  /// In en, this message translates to:
  /// **'Backup all now'**
  String get backupManagerBackupAll;

  /// No description provided for @backupManagerBackupLibrary.
  ///
  /// In en, this message translates to:
  /// **'Backup All Books'**
  String get backupManagerBackupLibrary;

  /// No description provided for @backupManagerBackupCollection.
  ///
  /// In en, this message translates to:
  /// **'Backup Collections'**
  String get backupManagerBackupCollection;

  /// No description provided for @backupManagerBackupBookmark.
  ///
  /// In en, this message translates to:
  /// **'Backup Bookmarks'**
  String get backupManagerBackupBookmark;

  /// No description provided for @backupManagerBackupSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Backup successfully'**
  String get backupManagerBackupSuccessfully;

  /// No description provided for @backupManagerBackupFailed.
  ///
  /// In en, this message translates to:
  /// **'Backup unsuccessfully'**
  String get backupManagerBackupFailed;

  /// No description provided for @backupManagerRestoreAll.
  ///
  /// In en, this message translates to:
  /// **'Restore all'**
  String get backupManagerRestoreAll;

  /// No description provided for @backupManagerRestoreLibrary.
  ///
  /// In en, this message translates to:
  /// **'Restore all books'**
  String get backupManagerRestoreLibrary;

  /// No description provided for @backupManagerRestoreCollection.
  ///
  /// In en, this message translates to:
  /// **'Restore Collections'**
  String get backupManagerRestoreCollection;

  /// No description provided for @backupManagerRestoreBookmark.
  ///
  /// In en, this message translates to:
  /// **'Restore Bookmarks'**
  String get backupManagerRestoreBookmark;

  /// No description provided for @backupManagerRestoreSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Restore successfully'**
  String get backupManagerRestoreSuccessfully;

  /// No description provided for @backupManagerRestoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore unsuccessfully'**
  String get backupManagerRestoreFailed;

  /// No description provided for @backupManagerDeleteAllBackup.
  ///
  /// In en, this message translates to:
  /// **'Delete all backups'**
  String get backupManagerDeleteAllBackup;

  /// No description provided for @backupManagerDeleteLibraryBackup.
  ///
  /// In en, this message translates to:
  /// **'Delete the backup of all books'**
  String get backupManagerDeleteLibraryBackup;

  /// No description provided for @backupManagerDeleteCollectionBackup.
  ///
  /// In en, this message translates to:
  /// **'Delete the backup of collections'**
  String get backupManagerDeleteCollectionBackup;

  /// No description provided for @backupManagerDeleteBookmarkBackup.
  ///
  /// In en, this message translates to:
  /// **'Delete the backup of bookmarks'**
  String get backupManagerDeleteBookmarkBackup;

  /// No description provided for @backupManagerDeleteBackupSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully delete backup'**
  String get backupManagerDeleteBackupSuccessfully;

  /// No description provided for @backupManagerDeleteBackupFailed.
  ///
  /// In en, this message translates to:
  /// **'Unsuccessfully delete backup'**
  String get backupManagerDeleteBackupFailed;

  /// No description provided for @backupManagerLastTime.
  ///
  /// In en, this message translates to:
  /// **'Last backup time'**
  String get backupManagerLastTime;

  /// No description provided for @backupManagerGoogleDrive.
  ///
  /// In en, this message translates to:
  /// **'Google Drive'**
  String get backupManagerGoogleDrive;

  /// No description provided for @resetPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetPageTitle;

  /// No description provided for @resetPageDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get resetPageDataTitle;

  /// No description provided for @resetPageDeleteAllBooks.
  ///
  /// In en, this message translates to:
  /// **'Delete all books'**
  String get resetPageDeleteAllBooks;

  /// No description provided for @resetPageDeleteAllBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Delete all bookmarks'**
  String get resetPageDeleteAllBookmarks;

  /// No description provided for @resetPageDeleteAllCollections.
  ///
  /// In en, this message translates to:
  /// **'Delete all collections'**
  String get resetPageDeleteAllCollections;

  /// No description provided for @resetPageCacheTitle.
  ///
  /// In en, this message translates to:
  /// **'Cache'**
  String get resetPageCacheTitle;

  /// No description provided for @resetPageCacheClear.
  ///
  /// In en, this message translates to:
  /// **'Clear all caches'**
  String get resetPageCacheClear;

  /// No description provided for @resetPagePreferenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Preference'**
  String get resetPagePreferenceTitle;

  /// No description provided for @resetPageResetPreference.
  ///
  /// In en, this message translates to:
  /// **'Reset all preferences'**
  String get resetPageResetPreference;

  /// No description provided for @resetPageResetThemeManager.
  ///
  /// In en, this message translates to:
  /// **'Reset the theme settings'**
  String get resetPageResetThemeManager;

  /// No description provided for @resetPageResetBackupManager.
  ///
  /// In en, this message translates to:
  /// **'Reset the backup settings'**
  String get resetPageResetBackupManager;

  /// No description provided for @resetPageResetBookshelf.
  ///
  /// In en, this message translates to:
  /// **'Reset the bookshelf settings'**
  String get resetPageResetBookshelf;

  /// No description provided for @resetPageResetCollectionList.
  ///
  /// In en, this message translates to:
  /// **'Reset the collections list settings'**
  String get resetPageResetCollectionList;

  /// No description provided for @resetPageResetBookmarkList.
  ///
  /// In en, this message translates to:
  /// **'Reset the bookmark list settings'**
  String get resetPageResetBookmarkList;

  /// No description provided for @resetPageResetReader.
  ///
  /// In en, this message translates to:
  /// **'Reset the reader settings'**
  String get resetPageResetReader;

  /// No description provided for @ttsSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Text-to-Speech Settings'**
  String get ttsSettingsTitle;

  /// No description provided for @ttsSettingsPlay.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get ttsSettingsPlay;

  /// No description provided for @ttsSettingsPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get ttsSettingsPause;

  /// No description provided for @ttsSettingsStop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get ttsSettingsStop;

  /// No description provided for @ttsSettingsReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get ttsSettingsReset;

  /// No description provided for @ttsSettingsPitch.
  ///
  /// In en, this message translates to:
  /// **'Pitch'**
  String get ttsSettingsPitch;

  /// No description provided for @ttsSettingsVolume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get ttsSettingsVolume;

  /// No description provided for @ttsSettingsSpeechRate.
  ///
  /// In en, this message translates to:
  /// **'Speech rate'**
  String get ttsSettingsSpeechRate;

  /// No description provided for @ttsSettingsTypeHere.
  ///
  /// In en, this message translates to:
  /// **'Type some text here'**
  String get ttsSettingsTypeHere;

  /// No description provided for @languageCodeSqAL.
  ///
  /// In en, this message translates to:
  /// **'Albanian (Albania)'**
  String get languageCodeSqAL;

  /// No description provided for @languageCodeAr.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageCodeAr;

  /// No description provided for @languageCodeAsIN.
  ///
  /// In en, this message translates to:
  /// **'Assamese (India)'**
  String get languageCodeAsIN;

  /// No description provided for @languageCodeBnBD.
  ///
  /// In en, this message translates to:
  /// **'Bengali (Bangladesh)'**
  String get languageCodeBnBD;

  /// No description provided for @languageCodeBnIN.
  ///
  /// In en, this message translates to:
  /// **'Bengali (India)'**
  String get languageCodeBnIN;

  /// No description provided for @languageCodeBrxIN.
  ///
  /// In en, this message translates to:
  /// **'Bodo (India)'**
  String get languageCodeBrxIN;

  /// No description provided for @languageCodeBsBA.
  ///
  /// In en, this message translates to:
  /// **'Bosnian (Bosnia and Herzegovina)'**
  String get languageCodeBsBA;

  /// No description provided for @languageCodeBgBG.
  ///
  /// In en, this message translates to:
  /// **'Bulgarian (Bulgaria)'**
  String get languageCodeBgBG;

  /// No description provided for @languageCodeYueHK.
  ///
  /// In en, this message translates to:
  /// **'Cantonese (Hong Kong)'**
  String get languageCodeYueHK;

  /// No description provided for @languageCodeCaES.
  ///
  /// In en, this message translates to:
  /// **'Catalan (Spain)'**
  String get languageCodeCaES;

  /// No description provided for @languageCodeZhCN.
  ///
  /// In en, this message translates to:
  /// **'Chinese (Simplified, China)'**
  String get languageCodeZhCN;

  /// No description provided for @languageCodeZhTW.
  ///
  /// In en, this message translates to:
  /// **'Chinese (Traditional, Taiwan)'**
  String get languageCodeZhTW;

  /// No description provided for @languageCodeHrHR.
  ///
  /// In en, this message translates to:
  /// **'Croatian (Croatia)'**
  String get languageCodeHrHR;

  /// No description provided for @languageCodeCsCZ.
  ///
  /// In en, this message translates to:
  /// **'Czech (Czech Republic)'**
  String get languageCodeCsCZ;

  /// No description provided for @languageCodeDaDK.
  ///
  /// In en, this message translates to:
  /// **'Danish (Denmark)'**
  String get languageCodeDaDK;

  /// No description provided for @languageCodeDoiIN.
  ///
  /// In en, this message translates to:
  /// **'Dogri (India)'**
  String get languageCodeDoiIN;

  /// No description provided for @languageCodeNlBE.
  ///
  /// In en, this message translates to:
  /// **'Dutch (Belgium)'**
  String get languageCodeNlBE;

  /// No description provided for @languageCodeNlNL.
  ///
  /// In en, this message translates to:
  /// **'Dutch (Netherlands)'**
  String get languageCodeNlNL;

  /// No description provided for @languageCodeEnAU.
  ///
  /// In en, this message translates to:
  /// **'English (Australia)'**
  String get languageCodeEnAU;

  /// No description provided for @languageCodeEnIN.
  ///
  /// In en, this message translates to:
  /// **'English (India)'**
  String get languageCodeEnIN;

  /// No description provided for @languageCodeEnNG.
  ///
  /// In en, this message translates to:
  /// **'English (Nigeria)'**
  String get languageCodeEnNG;

  /// No description provided for @languageCodeEnGB.
  ///
  /// In en, this message translates to:
  /// **'English (United Kingdom)'**
  String get languageCodeEnGB;

  /// No description provided for @languageCodeEnUS.
  ///
  /// In en, this message translates to:
  /// **'English (United States)'**
  String get languageCodeEnUS;

  /// No description provided for @languageCodeEtEE.
  ///
  /// In en, this message translates to:
  /// **'Estonian (Estonia)'**
  String get languageCodeEtEE;

  /// No description provided for @languageCodeFilPH.
  ///
  /// In en, this message translates to:
  /// **'Filipino (Philippines)'**
  String get languageCodeFilPH;

  /// No description provided for @languageCodeFiFI.
  ///
  /// In en, this message translates to:
  /// **'Finnish (Finland)'**
  String get languageCodeFiFI;

  /// No description provided for @languageCodeFrCA.
  ///
  /// In en, this message translates to:
  /// **'French (Canada)'**
  String get languageCodeFrCA;

  /// No description provided for @languageCodeFrFR.
  ///
  /// In en, this message translates to:
  /// **'French (France)'**
  String get languageCodeFrFR;

  /// No description provided for @languageCodeDeDE.
  ///
  /// In en, this message translates to:
  /// **'German (Germany)'**
  String get languageCodeDeDE;

  /// No description provided for @languageCodeElGR.
  ///
  /// In en, this message translates to:
  /// **'Greek (Greece)'**
  String get languageCodeElGR;

  /// No description provided for @languageCodeGuIN.
  ///
  /// In en, this message translates to:
  /// **'Gujarati (India)'**
  String get languageCodeGuIN;

  /// No description provided for @languageCodeHeIL.
  ///
  /// In en, this message translates to:
  /// **'Hebrew (Israel)'**
  String get languageCodeHeIL;

  /// No description provided for @languageCodeHiIN.
  ///
  /// In en, this message translates to:
  /// **'Hindi (India)'**
  String get languageCodeHiIN;

  /// No description provided for @languageCodeHuHU.
  ///
  /// In en, this message translates to:
  /// **'Hungarian (Hungary)'**
  String get languageCodeHuHU;

  /// No description provided for @languageCodeIsIS.
  ///
  /// In en, this message translates to:
  /// **'Icelandic (Iceland)'**
  String get languageCodeIsIS;

  /// No description provided for @languageCodeIdID.
  ///
  /// In en, this message translates to:
  /// **'Indonesian (Indonesia)'**
  String get languageCodeIdID;

  /// No description provided for @languageCodeItIT.
  ///
  /// In en, this message translates to:
  /// **'Italian (Italy)'**
  String get languageCodeItIT;

  /// No description provided for @languageCodeJaJP.
  ///
  /// In en, this message translates to:
  /// **'Japanese (Japan)'**
  String get languageCodeJaJP;

  /// No description provided for @languageCodeJvID.
  ///
  /// In en, this message translates to:
  /// **'Javanese (Indonesia)'**
  String get languageCodeJvID;

  /// No description provided for @languageCodeKnIN.
  ///
  /// In en, this message translates to:
  /// **'Kannada (India)'**
  String get languageCodeKnIN;

  /// No description provided for @languageCodeKsIN.
  ///
  /// In en, this message translates to:
  /// **'Kashmiri (India)'**
  String get languageCodeKsIN;

  /// No description provided for @languageCodeKmKH.
  ///
  /// In en, this message translates to:
  /// **'Khmer (Cambodia)'**
  String get languageCodeKmKH;

  /// No description provided for @languageCodeKokIN.
  ///
  /// In en, this message translates to:
  /// **'Konkani (India)'**
  String get languageCodeKokIN;

  /// No description provided for @languageCodeKoKR.
  ///
  /// In en, this message translates to:
  /// **'Korean (South Korea)'**
  String get languageCodeKoKR;

  /// No description provided for @languageCodeLvLV.
  ///
  /// In en, this message translates to:
  /// **'Latvian (Latvia)'**
  String get languageCodeLvLV;

  /// No description provided for @languageCodeLtLT.
  ///
  /// In en, this message translates to:
  /// **'Lithuanian (Lithuania)'**
  String get languageCodeLtLT;

  /// No description provided for @languageCodeMaiIN.
  ///
  /// In en, this message translates to:
  /// **'Maithili (India)'**
  String get languageCodeMaiIN;

  /// No description provided for @languageCodeMsMY.
  ///
  /// In en, this message translates to:
  /// **'Malay (Malaysia)'**
  String get languageCodeMsMY;

  /// No description provided for @languageCodeMlIN.
  ///
  /// In en, this message translates to:
  /// **'Malayalam (India)'**
  String get languageCodeMlIN;

  /// No description provided for @languageCodeMniIN.
  ///
  /// In en, this message translates to:
  /// **'Manipuri (Meitei, India)'**
  String get languageCodeMniIN;

  /// No description provided for @languageCodeMrIN.
  ///
  /// In en, this message translates to:
  /// **'Marathi (India)'**
  String get languageCodeMrIN;

  /// No description provided for @languageCodeNeNP.
  ///
  /// In en, this message translates to:
  /// **'Nepali (Nepal)'**
  String get languageCodeNeNP;

  /// No description provided for @languageCodeNbNO.
  ///
  /// In en, this message translates to:
  /// **'Norwegian Bokmål (Norway)'**
  String get languageCodeNbNO;

  /// No description provided for @languageCodeOrIN.
  ///
  /// In en, this message translates to:
  /// **'Odia (Oriya, India)'**
  String get languageCodeOrIN;

  /// No description provided for @languageCodePlPL.
  ///
  /// In en, this message translates to:
  /// **'Polish (Poland)'**
  String get languageCodePlPL;

  /// No description provided for @languageCodePtBR.
  ///
  /// In en, this message translates to:
  /// **'Portuguese (Brazil)'**
  String get languageCodePtBR;

  /// No description provided for @languageCodePtPT.
  ///
  /// In en, this message translates to:
  /// **'Portuguese (Portugal)'**
  String get languageCodePtPT;

  /// No description provided for @languageCodePaIN.
  ///
  /// In en, this message translates to:
  /// **'Punjabi (India)'**
  String get languageCodePaIN;

  /// No description provided for @languageCodeRoRO.
  ///
  /// In en, this message translates to:
  /// **'Romanian (Romania)'**
  String get languageCodeRoRO;

  /// No description provided for @languageCodeRuRU.
  ///
  /// In en, this message translates to:
  /// **'Russian (Russia)'**
  String get languageCodeRuRU;

  /// No description provided for @languageCodeSaIN.
  ///
  /// In en, this message translates to:
  /// **'Sanskrit (India)'**
  String get languageCodeSaIN;

  /// No description provided for @languageCodeSatIN.
  ///
  /// In en, this message translates to:
  /// **'Santali (India)'**
  String get languageCodeSatIN;

  /// No description provided for @languageCodeSrRS.
  ///
  /// In en, this message translates to:
  /// **'Serbian (Serbia)'**
  String get languageCodeSrRS;

  /// No description provided for @languageCodeSdIN.
  ///
  /// In en, this message translates to:
  /// **'Sindhi (India)'**
  String get languageCodeSdIN;

  /// No description provided for @languageCodeSiLK.
  ///
  /// In en, this message translates to:
  /// **'Sinhala (Sri Lanka)'**
  String get languageCodeSiLK;

  /// No description provided for @languageCodeSkSK.
  ///
  /// In en, this message translates to:
  /// **'Slovak (Slovakia)'**
  String get languageCodeSkSK;

  /// No description provided for @languageCodeSlSI.
  ///
  /// In en, this message translates to:
  /// **'Slovenian (Slovenia)'**
  String get languageCodeSlSI;

  /// No description provided for @languageCodeEsES.
  ///
  /// In en, this message translates to:
  /// **'Spanish (Spain)'**
  String get languageCodeEsES;

  /// No description provided for @languageCodeEsUS.
  ///
  /// In en, this message translates to:
  /// **'Spanish (United States)'**
  String get languageCodeEsUS;

  /// No description provided for @languageCodeSuID.
  ///
  /// In en, this message translates to:
  /// **'Sundanese (Indonesia)'**
  String get languageCodeSuID;

  /// No description provided for @languageCodeSwKE.
  ///
  /// In en, this message translates to:
  /// **'Swahili (Kenya)'**
  String get languageCodeSwKE;

  /// No description provided for @languageCodeSvSE.
  ///
  /// In en, this message translates to:
  /// **'Swedish (Sweden)'**
  String get languageCodeSvSE;

  /// No description provided for @languageCodeTaIN.
  ///
  /// In en, this message translates to:
  /// **'Tamil (India)'**
  String get languageCodeTaIN;

  /// No description provided for @languageCodeTeIN.
  ///
  /// In en, this message translates to:
  /// **'Telugu (India)'**
  String get languageCodeTeIN;

  /// No description provided for @languageCodeThTH.
  ///
  /// In en, this message translates to:
  /// **'Thai (Thailand)'**
  String get languageCodeThTH;

  /// No description provided for @languageCodeTrTR.
  ///
  /// In en, this message translates to:
  /// **'Turkish (Turkey)'**
  String get languageCodeTrTR;

  /// No description provided for @languageCodeUkUA.
  ///
  /// In en, this message translates to:
  /// **'Ukrainian (Ukraine)'**
  String get languageCodeUkUA;

  /// No description provided for @languageCodeUrIN.
  ///
  /// In en, this message translates to:
  /// **'Urdu (India)'**
  String get languageCodeUrIN;

  /// No description provided for @languageCodeUrPK.
  ///
  /// In en, this message translates to:
  /// **'Urdu (Pakistan)'**
  String get languageCodeUrPK;

  /// No description provided for @languageCodeViVN.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese (Vietnam)'**
  String get languageCodeViVN;

  /// No description provided for @languageCodeCyGB.
  ///
  /// In en, this message translates to:
  /// **'Welsh (United Kingdom)'**
  String get languageCodeCyGB;

  /// No description provided for @languageCodeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown language: \${code}'**
  String languageCodeUnknown(Object code);

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @fileEmpty.
  ///
  /// In en, this message translates to:
  /// **'No file selected'**
  String get fileEmpty;

  /// No description provided for @fileTypeHelperText.
  ///
  /// In en, this message translates to:
  /// **'Only accept these type of files:'**
  String get fileTypeHelperText;

  /// No description provided for @fileSystemUntitledFile.
  ///
  /// In en, this message translates to:
  /// **'Untitled File'**
  String get fileSystemUntitledFile;

  /// No description provided for @fileSystemCreateOnDate.
  ///
  /// In en, this message translates to:
  /// **'Create on {datetime}'**
  String fileSystemCreateOnDate(Object datetime);

  /// No description provided for @fileSystemPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission Denied'**
  String get fileSystemPermissionDenied;

  /// No description provided for @dialogDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get dialogDeleteTitle;

  /// No description provided for @dialogDeleteContent.
  ///
  /// In en, this message translates to:
  /// **'You will not be able to restore them.'**
  String get dialogDeleteContent;

  /// No description provided for @alertDialogResetSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset settings'**
  String get alertDialogResetSettingsTitle;

  /// No description provided for @alertDialogResetSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to reset settings?'**
  String get alertDialogResetSettingsDescription;

  /// No description provided for @accessibilityBackButton.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get accessibilityBackButton;

  /// No description provided for @accessibilityAddBookButton.
  ///
  /// In en, this message translates to:
  /// **'Add a book'**
  String get accessibilityAddBookButton;

  /// No description provided for @accessibilityThemeSelectionButton.
  ///
  /// In en, this message translates to:
  /// **'Use {name} theme'**
  String accessibilityThemeSelectionButton(Object name);

  /// No description provided for @accessibilityAppIcon.
  ///
  /// In en, this message translates to:
  /// **'NovelGlide icon'**
  String get accessibilityAppIcon;

  /// No description provided for @accessibilityBookCover.
  ///
  /// In en, this message translates to:
  /// **'The book cover'**
  String get accessibilityBookCover;

  /// No description provided for @accessibilityBookshelfListItem.
  ///
  /// In en, this message translates to:
  /// **'A book'**
  String get accessibilityBookshelfListItem;

  /// No description provided for @accessibilityBookshelfListItemOnTap.
  ///
  /// In en, this message translates to:
  /// **'Tap to open this book'**
  String get accessibilityBookshelfListItemOnTap;

  /// No description provided for @accessibilityBookshelfListItemOnLongPress.
  ///
  /// In en, this message translates to:
  /// **'Long press and drag to delete the book'**
  String get accessibilityBookshelfListItemOnLongPress;

  /// No description provided for @accessibilityReaderPrevChapterButton.
  ///
  /// In en, this message translates to:
  /// **'Previous chapter'**
  String get accessibilityReaderPrevChapterButton;

  /// No description provided for @accessibilityReaderNextChapterButton.
  ///
  /// In en, this message translates to:
  /// **'Next chapter'**
  String get accessibilityReaderNextChapterButton;

  /// No description provided for @accessibilityReaderBookmarkButton.
  ///
  /// In en, this message translates to:
  /// **'Jump to the bookmark'**
  String get accessibilityReaderBookmarkButton;

  /// No description provided for @accessibilityReaderAddBookmarkButton.
  ///
  /// In en, this message translates to:
  /// **'Add a bookmark'**
  String get accessibilityReaderAddBookmarkButton;

  /// No description provided for @accessibilityReaderSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Reader settings'**
  String get accessibilityReaderSettingsButton;

  /// No description provided for @accessibilityFontSizeSliderMinIcon.
  ///
  /// In en, this message translates to:
  /// **'Minimum font size'**
  String get accessibilityFontSizeSliderMinIcon;

  /// No description provided for @accessibilityFontSizeSliderMaxIcon.
  ///
  /// In en, this message translates to:
  /// **'Maximum font size'**
  String get accessibilityFontSizeSliderMaxIcon;

  /// No description provided for @accessibilityFontSizeSlider.
  ///
  /// In en, this message translates to:
  /// **'Font size slider'**
  String get accessibilityFontSizeSlider;

  /// No description provided for @accessibilityLineHeightSliderMinIcon.
  ///
  /// In en, this message translates to:
  /// **'Minimum line height'**
  String get accessibilityLineHeightSliderMinIcon;

  /// No description provided for @accessibilityLineHeightSliderMaxIcon.
  ///
  /// In en, this message translates to:
  /// **'Maximum line height'**
  String get accessibilityLineHeightSliderMaxIcon;

  /// No description provided for @accessibilityLineHeightSlider.
  ///
  /// In en, this message translates to:
  /// **'Line height slider'**
  String get accessibilityLineHeightSlider;

  /// No description provided for @exceptionUnknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown Error Occurred'**
  String get exceptionUnknownError;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
    // Lookup logic when language+script+country codes are specified.
  switch (locale.toString()) {
    case 'zh_Hans_CN': return AppLocalizationsZhHansCn();
  }


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
