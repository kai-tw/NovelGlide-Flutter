import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../bookmark/domain/entities/bookmark_data.dart';
import '../../../../bookmark/domain/use_cases/bookmark_get_data_use_case.dart';
import '../../../../bookmark/domain/use_cases/bookmark_update_data_use_case.dart';
import '../../../../books/domain/entities/book.dart';
import '../../../../books/domain/use_cases/book_get_use_case.dart';
import '../../../../preference/domain/entities/reader_preference_data.dart';
import '../../../../preference/domain/use_cases/preference_get_use_cases.dart';
import '../../../../preference/domain/use_cases/preference_observe_change_use_case.dart';
import '../../../../preference/domain/use_cases/preference_reset_use_case.dart';
import '../../../../preference/domain/use_cases/preference_save_use_case.dart';
import '../../../../tts_service/domain/use_cases/tts_observe_state_changed_use_case.dart';
import '../../../../tts_service/domain/use_cases/tts_pause_use_case.dart';
import '../../../../tts_service/domain/use_cases/tts_reload_preference_use_case.dart';
import '../../../../tts_service/domain/use_cases/tts_resume_use_case.dart';
import '../../../../tts_service/domain/use_cases/tts_speak_use_case.dart';
import '../../../../tts_service/domain/use_cases/tts_stop_use_case.dart';
import '../../../data/data_transfer_objects/reader_web_message_dto.dart';
import '../../../data/repositories/reader_search_repository_impl.dart';
import '../../../data/repositories/reader_tts_repository_impl.dart';
import '../../../data/repositories/reader_web_view_repository_impl.dart';
import '../../../domain/entities/reader_destination_type.dart';
import '../../../domain/entities/reader_navigation_state_code.dart';
import '../../../domain/entities/reader_page_num_type.dart';
import '../../../domain/entities/reader_set_state_data.dart';
import '../../../domain/repositories/reader_search_repository.dart';
import '../../../domain/repositories/reader_tts_repository.dart';
import '../../../domain/repositories/reader_web_view_repository.dart';
import '../../../domain/use_cases/reader_get_location_cache_use_case.dart';
import '../../../domain/use_cases/reader_observe_load_done_use_case.dart';
import '../../../domain/use_cases/reader_observe_save_location_use_case.dart';
import '../../../domain/use_cases/reader_observe_search_list_use_case.dart';
import '../../../domain/use_cases/reader_observe_set_state_use_case.dart';
import '../../../domain/use_cases/reader_observe_tts_end_use_case.dart';
import '../../../domain/use_cases/reader_observe_tts_play_use_case.dart';
import '../../../domain/use_cases/reader_observe_tts_stop_use_case.dart';
import '../../../domain/use_cases/reader_send_goto_use_case.dart';
import '../../../domain/use_cases/reader_send_next_page_use_case.dart';
import '../../../domain/use_cases/reader_send_previous_page_use_case.dart';
import '../../../domain/use_cases/reader_send_search_in_current_chapter_use_case.dart';
import '../../../domain/use_cases/reader_send_search_in_whole_book_use_case.dart';
import '../../../domain/use_cases/reader_send_set_font_color_use_case.dart';
import '../../../domain/use_cases/reader_send_set_font_size_use_case.dart';
import '../../../domain/use_cases/reader_send_set_line_height_use_case.dart';
import '../../../domain/use_cases/reader_send_set_smooth_scroll_use_case.dart';
import '../../../domain/use_cases/reader_send_tts_next_use_case.dart';
import '../../../domain/use_cases/reader_send_tts_play_use_case.dart';
import '../../../domain/use_cases/reader_send_tts_stop_use_case.dart';
import '../../../domain/use_cases/reader_start_reader_server_use_case.dart';
import '../../../domain/use_cases/reader_stop_reader_server_use_case.dart';
import '../../../domain/use_cases/reader_store_location_cache_use_case.dart';
import '../../search_page/cubit/reader_search_cubit.dart';
import 'reader_tts_cubit.dart';

part '../../../domain/entities/reader_loading_state_code.dart';
part 'reader_gesture_handler.dart';
part 'reader_state.dart';
part 'reader_web_view_handler.dart';

class ReaderCubit extends Cubit<ReaderState> {
  factory ReaderCubit(
    // Server use cases
    ReaderStartReaderServerUseCase startReaderServerUseCase,
    ReaderStopReaderServerUseCase stopReaderServerUseCase,
    // Book use cases
    BookGetUseCase bookGetUseCase,
    // Location cache use cases
    ReaderStoreLocationCacheUseCase storeLocationCacheUseCase,
    ReaderGetLocationCacheUseCase getLocationCacheUseCase,
    // Bookmark use cases
    BookmarkGetDataUseCase bookmarkGetDataUseCase,
    BookmarkUpdateDataUseCase bookmarkUpdateDataUseCase,
    // Reader preference use cases.
    ReaderGetPreferenceUseCase getPreferenceUseCase,
    ReaderSavePreferenceUseCase savePreferenceUseCase,
    ReaderObservePreferenceChangeUseCase observePreferenceChangeUseCase,
    ReaderResetPreferenceUseCase resetPreferenceUseCase,
    // TTS use cases
    TtsReloadPreferenceUseCase ttsReloadPreferenceUseCase,
    TtsObserveStateChangedUseCase ttsObserveStateChangedUseCase,
    TtsSpeakUseCase ttsSpeakUseCase,
    TtsStopUseCase ttsStopUseCase,
    TtsPauseUseCase ttsPauseUseCase,
    TtsResumeUseCase ttsResumeUseCase,
  ) {
    // Setup webview dependencies
    final WebViewController webViewController = WebViewController();
    final ReaderWebViewRepository webViewRepository =
        ReaderWebViewRepositoryImpl(webViewController);

    // Create searching dependencies
    final ReaderSearchRepository searchRepository =
        ReaderSearchRepositoryImpl(webViewRepository);

    // Create TTS dependencies
    final ReaderTtsRepository ttsRepository =
        ReaderTtsRepositoryImpl(webViewRepository);

    final ReaderCubit cubit = ReaderCubit._(
      // Server use cases
      startReaderServerUseCase,
      stopReaderServerUseCase,
      // Communication use cases
      ReaderObserveSaveLocationUseCase(webViewRepository),
      ReaderObserveSetStateUseCase(webViewRepository),
      ReaderObserveLoadDoneUseCase(webViewRepository),
      ReaderSendPreviousPageUseCase(webViewRepository),
      ReaderSendNextPageUseCase(webViewRepository),
      ReaderSendSetFontColorUseCase(webViewRepository),
      ReaderSendSetFontSizeUseCase(webViewRepository),
      ReaderSendSetLineHeightUseCase(webViewRepository),
      ReaderSendSetSmoothScrollUseCase(webViewRepository),
      // Book use cases
      bookGetUseCase,
      // Location cache use cases
      storeLocationCacheUseCase,
      getLocationCacheUseCase,
      // Bookmark use cases
      bookmarkGetDataUseCase,
      bookmarkUpdateDataUseCase,
      // Reader preference use cases
      getPreferenceUseCase,
      savePreferenceUseCase,
      resetPreferenceUseCase,
      // Dependencies
      webViewController,
      webViewRepository,
      searchRepository,
      ttsRepository,
      // Cubits
      ReaderSearchCubit(
        ReaderSendSearchInCurrentChapterUseCase(webViewRepository),
        ReaderSendSearchInWholeBookUseCase(webViewRepository),
        ReaderSendGotoUseCase(webViewRepository),
        ReaderObserveSearchListUseCase(searchRepository),
      ),
      ReaderTtsCubit(
        ReaderSendTtsNextUseCase(webViewRepository),
        ReaderSendTtsPlayUseCase(webViewRepository),
        ReaderSendTtsStopUseCase(webViewRepository),
        ReaderObserveTtsEndUseCase(ttsRepository),
        ReaderObserveTtsPlayUseCase(ttsRepository),
        ReaderObserveTtsStopUseCase(ttsRepository),
        ttsReloadPreferenceUseCase,
        ttsObserveStateChangedUseCase,
        ttsSpeakUseCase,
        ttsStopUseCase,
        ttsPauseUseCase,
        ttsResumeUseCase,
      ),
    );

    // Stream listeners
    cubit._preferenceSubscription =
        observePreferenceChangeUseCase().listen(cubit._refreshPreference);

    return cubit;
  }

  ReaderCubit._(
    // Server use cases
    this._startReaderServerUseCase,
    this._stopReaderServerUseCase,
    // Communication use cases
    this._observeSaveLocationUseCase,
    this._observeSetStateUseCase,
    this._observeLoadDoneUseCase,
    this._sendPreviousPageUseCase,
    this._sendNextPageUseCase,
    this._sendSetFontColorUseCase,
    this._sendSetFontSizeUseCase,
    this._sendSetLineHeightUseCase,
    this._sendSetSmoothScrollUseCase,
    // Book use cases
    this._bookGetUseCase,
    // Location cache use cases
    this._storeLocationCacheUseCase,
    this._getLocationCacheUseCase,
    // Bookmark use cases
    this._bookmarkGetDataUseCase,
    this._bookmarkUpdateDataUseCase,
    // Reader preference use cases
    this._getPreferenceUseCase,
    this._savePreferenceUseCase,
    this._resetPreferenceUseCase,
    // Dependencies
    this.webViewController,
    this._webViewRepository,
    this._searchRepository,
    this._ttsRepository,
    this.searchCubit,
    this.ttsCubit,
  ) : super(const ReaderState());

  Book? bookData;
  late ThemeData currentTheme;

  late final ReaderWebViewHandler webViewHandler;
  final ReaderSearchCubit searchCubit;
  final ReaderTtsCubit ttsCubit;

  late final ReaderGestureHandler gestureHandler =
      ReaderGestureHandler(onSwipeLeft: previousPage, onSwipeRight: nextPage);

  /// Dependencies
  final WebViewController webViewController;
  final ReaderWebViewRepository _webViewRepository;
  final ReaderSearchRepository _searchRepository;
  final ReaderTtsRepository _ttsRepository;

  /// Stream Subscriptions
  late final StreamSubscription<String> _saveLocationStreamSubscription;
  late final StreamSubscription<void> _loadDoneStreamSubscription;
  late final StreamSubscription<ReaderSetStateData> _setStateStreamSubscription;

  /// Server use cases
  final ReaderStartReaderServerUseCase _startReaderServerUseCase;
  final ReaderStopReaderServerUseCase _stopReaderServerUseCase;

  /// Communication use cases
  final ReaderObserveSaveLocationUseCase _observeSaveLocationUseCase;
  final ReaderObserveLoadDoneUseCase _observeLoadDoneUseCase;
  final ReaderObserveSetStateUseCase _observeSetStateUseCase;
  final ReaderSendPreviousPageUseCase _sendPreviousPageUseCase;
  final ReaderSendNextPageUseCase _sendNextPageUseCase;
  final ReaderSendSetFontColorUseCase _sendSetFontColorUseCase;
  final ReaderSendSetFontSizeUseCase _sendSetFontSizeUseCase;
  final ReaderSendSetLineHeightUseCase _sendSetLineHeightUseCase;
  final ReaderSendSetSmoothScrollUseCase _sendSetSmoothScrollUseCase;

  /// Book use cases
  final BookGetUseCase _bookGetUseCase;

  /// Location cache use cases
  final ReaderStoreLocationCacheUseCase _storeLocationCacheUseCase;
  final ReaderGetLocationCacheUseCase _getLocationCacheUseCase;

  /// Bookmark use cases
  final BookmarkGetDataUseCase _bookmarkGetDataUseCase;
  final BookmarkUpdateDataUseCase _bookmarkUpdateDataUseCase;

  /// Reader preference use cases
  final ReaderGetPreferenceUseCase _getPreferenceUseCase;
  final ReaderSavePreferenceUseCase _savePreferenceUseCase;
  final ReaderResetPreferenceUseCase _resetPreferenceUseCase;

  /// Preference Stream Subscription
  late final StreamSubscription<ReaderPreferenceData> _preferenceSubscription;

  /// Initialize from widgets.
  Future<void> initAsync({
    required String bookIdentifier,
    required ThemeData currentTheme,
    required ReaderDestinationType destinationType,
    String? destination,
    Book? bookData,
  }) async {
    // Initialize members
    this.currentTheme = currentTheme;
    this.bookData = bookData;

    // Initialize
    emit(state.copyWith(
      bookName: bookData?.title,
      code: ReaderLoadingStateCode.bookLoading,
    ));

    // Start loading the data of book, reader settings, and bookmarks.
    late ReaderPreferenceData readerSettingsData;
    late BookmarkData? bookmarkData;
    await Future.wait<void>(<Future<void>>[
      _bookGetUseCase(bookIdentifier)
          .then((Book value) => this.bookData = value),
      _getPreferenceUseCase()
          .then((ReaderPreferenceData value) => readerSettingsData = value),
      _bookmarkGetDataUseCase(bookIdentifier)
          .then((BookmarkData? data) => bookmarkData = data),
    ]);

    // Start back-end server
    final Uri serverUri = await _startReaderServerUseCase(bookIdentifier);

    // Initialize webview handler
    webViewHandler = ReaderWebViewHandler(
      controller: webViewController,
      repository: _webViewRepository,
      uri: serverUri,
      destination: destinationType == ReaderDestinationType.bookmark
          ? bookmarkData?.startCfi ?? destination
          : destination,
      savedLocation: await _getLocationCacheUseCase(bookIdentifier),
    );

    // Listen messages
    _saveLocationStreamSubscription =
        _observeSaveLocationUseCase().listen(_receiveSaveLocation);
    _loadDoneStreamSubscription =
        _observeLoadDoneUseCase().listen(_receiveLoadDone);
    _setStateStreamSubscription =
        _observeSetStateUseCase().listen(_receiveSetState);

    if (isClosed) {
      return;
    }

    // Emit state.
    emit(state.copyWith(
      code: ReaderLoadingStateCode.rendering,
      bookName: this.bookData?.title,
      bookmarkData: bookmarkData,
      readerPreference: readerSettingsData,
    ));

    // Start loading the page.
    webViewHandler.request();
  }

  void setNavState(ReaderNavigationStateCode code) {
    emit(state.copyWith(navigationStateCode: code));
  }

  void sendThemeData([ThemeData? newTheme]) {
    currentTheme = newTheme ?? currentTheme;
    if (state.code.isLoaded) {
      _sendSetFontColorUseCase(currentTheme.colorScheme.onSurface);
      _sendSetFontSizeUseCase(state.readerPreference.fontSize);
      _sendSetLineHeightUseCase(state.readerPreference.lineHeight);
    }
  }

  /// *************************************************************************
  /// Settings
  /// *************************************************************************

  set fontSize(double value) {
    emit(state.copyWith(
      readerPreference: state.readerPreference.copyWith(
        fontSize: value,
      ),
    ));
  }

  set lineHeight(double value) {
    emit(state.copyWith(
      readerPreference: state.readerPreference.copyWith(
        lineHeight: value,
      ),
    ));
  }

  set isAutoSaving(bool value) {
    emit(state.copyWith(
      readerPreference: state.readerPreference.copyWith(
        isAutoSaving: value,
      ),
    ));
    if (value) {
      saveBookmark();
    }
  }

  set isSmoothScroll(bool value) {
    emit(state.copyWith(
      readerPreference: state.readerPreference.copyWith(
        isSmoothScroll: value,
      ),
    ));
    _sendSetSmoothScrollUseCase(value);
  }

  set pageNumType(ReaderPageNumType value) {
    emit(state.copyWith(
      readerPreference: state.readerPreference.copyWith(
        pageNumType: value,
      ),
    ));
  }

  void savePreference() => _savePreferenceUseCase(state.readerPreference);

  Future<void> resetPreference() async {
    await _resetPreferenceUseCase();
  }

  Future<void> _refreshPreference(ReaderPreferenceData data) async {
    emit(state.copyWith(
      readerPreference: data,
    ));
    sendThemeData();
  }

  /// *************************************************************************
  /// Bookmarks
  /// *************************************************************************

  void saveBookmark() {
    final BookmarkData data = BookmarkData(
      bookIdentifier: bookData!.identifier,
      bookName: state.bookName,
      chapterTitle: state.breadcrumb,
      chapterIdentifier: state.chapterFileName,
      startCfi: state.startCfi,
      savedTime: DateTime.now(),
    );

    _bookmarkUpdateDataUseCase(<BookmarkData>{data});

    emit(state.copyWith(bookmarkData: data));
  }

  /// *************************************************************************
  /// Page Navigation
  /// *************************************************************************

  void previousPage() {
    _sendPreviousPageUseCase();
  }

  void nextPage() {
    _sendNextPageUseCase();
  }

  /// *************************************************************************
  /// Communication
  /// *************************************************************************

  void _receiveSaveLocation(String locationData) {
    if (bookData != null) {
      _storeLocationCacheUseCase(ReaderStoreLocationCacheUseCaseParam(
        bookIdentifier: bookData!.identifier,
        location: locationData,
      ));
    }
  }

  void _receiveLoadDone(void _) {
    _stopReaderServerUseCase();
    emit(state.copyWith(code: ReaderLoadingStateCode.loaded));

    // Send theme data after the page is loaded.
    sendThemeData();

    // Set smooth scroll.
    _sendSetSmoothScrollUseCase(state.readerPreference.isSmoothScroll);
  }

  void _receiveSetState(ReaderSetStateData data) {
    emit(state.copyWith(
      breadcrumb: data.breadcrumb,
      chapterFileName: data.chapterIdentifier,
      startCfi: data.startCfi,
      chapterCurrentPage: data.chapterCurrentPage,
      chapterTotalPage: data.chapterTotalPage,
    ));

    if (state.readerPreference.isAutoSaving) {
      saveBookmark();
    }
  }

  /// *************************************************************************
  /// Miscellaneous
  /// *************************************************************************

  @override
  Future<void> close() async {
    await _preferenceSubscription.cancel();
    await _saveLocationStreamSubscription.cancel();
    await _loadDoneStreamSubscription.cancel();
    await _setStateStreamSubscription.cancel();
    await _stopReaderServerUseCase();
    await _webViewRepository.dispose();
    await _searchRepository.dispose();
    await _ttsRepository.dispose();
    await searchCubit.close();
    super.close();
  }
}
