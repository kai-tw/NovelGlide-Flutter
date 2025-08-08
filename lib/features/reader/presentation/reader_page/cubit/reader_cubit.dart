import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../../core/services/preference_service/data/model/reader_preference_data.dart';
import '../../../../../core/services/preference_service/preference_service.dart';
import '../../../../bookmark_service/bookmark_service.dart';
import '../../../../books/domain/entities/book.dart';
import '../../../../books/domain/use_cases/get_book_use_case.dart';
import '../../../../tts_service/tts_service.dart';
import '../../../data/data_transfer_objects/reader_web_message_dto.dart';
import '../../../data/repositories/reader_search_repository_impl.dart';
import '../../../data/repositories/reader_server_repository_impl.dart';
import '../../../data/repositories/reader_web_view_repository_impl.dart';
import '../../../data/repository/cache_repository.dart';
import '../../../domain/entities/reader_destination_type.dart';
import '../../../domain/entities/reader_navigation_state_code.dart';
import '../../../domain/entities/reader_page_num_type.dart';
import '../../../domain/entities/reader_set_state_data.dart';
import '../../../domain/repositories/reader_search_repository.dart';
import '../../../domain/repositories/reader_server_repository.dart';
import '../../../domain/repositories/reader_web_view_repository.dart';
import '../../../domain/use_cases/reader_observe_load_done_use_case.dart';
import '../../../domain/use_cases/reader_observe_save_location_use_case.dart';
import '../../../domain/use_cases/reader_observe_search_list_use_case.dart';
import '../../../domain/use_cases/reader_observe_set_state_use_case.dart';
import '../../../domain/use_cases/reader_send_goto_use_case.dart';
import '../../../domain/use_cases/reader_send_next_page_use_case.dart';
import '../../../domain/use_cases/reader_send_previous_page_use_case.dart';
import '../../../domain/use_cases/reader_send_search_in_current_chapter_use_case.dart';
import '../../../domain/use_cases/reader_send_search_in_whole_book_use_case.dart';
import '../../../domain/use_cases/reader_send_set_font_color_use_case.dart';
import '../../../domain/use_cases/reader_send_set_font_size_use_case.dart';
import '../../../domain/use_cases/reader_send_set_line_height_use_case.dart';
import '../../../domain/use_cases/reader_send_set_smooth_scroll_use_case.dart';
import '../../../domain/use_cases/reader_start_reader_server_use_case.dart';
import '../../../domain/use_cases/reader_stop_reader_server_use_case.dart';
import '../../search_page/cubit/reader_search_cubit.dart';

part '../../../domain/entities/reader_loading_state_code.dart';
part 'reader_gesture_handler.dart';
part 'reader_state.dart';
part 'reader_tts_handler.dart';
part 'reader_web_view_handler.dart';

class ReaderCubit extends Cubit<ReaderState> {
  factory ReaderCubit(
    FileSystemRepository fileSystemRepository,
    GetBookUseCase getBookUseCase,
  ) {
    // Setup server dependencies
    final ReaderServerRepository serverRepository =
        ReaderServerRepositoryImpl(fileSystemRepository);
    final ReaderStartReaderServerUseCase startReaderServerUseCase =
        ReaderStartReaderServerUseCase(serverRepository);
    final ReaderStopReaderServerUseCase stopReaderServerUseCase =
        ReaderStopReaderServerUseCase(serverRepository);

    // Setup webview dependencies
    final WebViewController webViewController = WebViewController();
    final ReaderWebViewRepository webViewRepository =
        ReaderWebViewRepositoryImpl(webViewController);
    final ReaderSearchRepository searchRepository =
        ReaderSearchRepositoryImpl(webViewRepository);

    // Create reader use cases
    final ReaderSendGotoUseCase sendGotoUseCase =
        ReaderSendGotoUseCase(webViewRepository);
    final ReaderObserveSaveLocationUseCase observeSaveLocationUseCase =
        ReaderObserveSaveLocationUseCase(webViewRepository);
    final ReaderObserveLoadDoneUseCase observeLoadDoneUseCase =
        ReaderObserveLoadDoneUseCase(webViewRepository);
    final ReaderObserveSetStateUseCase observeSetStateUseCase =
        ReaderObserveSetStateUseCase(webViewRepository);
    final ReaderSendPreviousPageUseCase sendPreviousPageUseCase =
        ReaderSendPreviousPageUseCase(webViewRepository);
    final ReaderSendNextPageUseCase sendNextPageUseCase =
        ReaderSendNextPageUseCase(webViewRepository);
    final ReaderSendSetFontColorUseCase sendSetFontColorUseCase =
        ReaderSendSetFontColorUseCase(webViewRepository);
    final ReaderSendSetFontSizeUseCase sendSetFontSizeUseCase =
        ReaderSendSetFontSizeUseCase(webViewRepository);
    final ReaderSendSetLineHeightUseCase sendSetLineHeightUseCase =
        ReaderSendSetLineHeightUseCase(webViewRepository);
    final ReaderSendSetSmoothScrollUseCase sendSetSmoothScrollUseCase =
        ReaderSendSetSmoothScrollUseCase(webViewRepository);

    // Create searching use cases
    final ReaderSendSearchInCurrentChapterUseCase
        sendSearchInCurrentChapterUseCase =
        ReaderSendSearchInCurrentChapterUseCase(webViewRepository);
    final ReaderSendSearchInWholeBookUseCase sendSearchInWholeBookUseCase =
        ReaderSendSearchInWholeBookUseCase(webViewRepository);
    final ReaderObserveSearchListUseCase observeSearchListUseCase =
        ReaderObserveSearchListUseCase(searchRepository);

    return ReaderCubit._(
      startReaderServerUseCase,
      stopReaderServerUseCase,
      observeSaveLocationUseCase,
      observeSetStateUseCase,
      observeLoadDoneUseCase,
      sendPreviousPageUseCase,
      sendNextPageUseCase,
      sendSetFontColorUseCase,
      sendSetFontSizeUseCase,
      sendSetLineHeightUseCase,
      sendSetSmoothScrollUseCase,
      getBookUseCase,
      webViewController,
      webViewRepository,
      searchRepository,
      ReaderSearchCubit(
        sendSearchInCurrentChapterUseCase,
        sendSearchInWholeBookUseCase,
        sendGotoUseCase,
        observeSearchListUseCase,
      ),
    );
  }

  ReaderCubit._(
    this._startReaderServerUseCase,
    this._stopReaderServerUseCase,
    this._observeSaveLocationUseCase,
    this._observeSetStateUseCase,
    this._observeLoadDoneUseCase,
    this._sendPreviousPageUseCase,
    this._sendNextPageUseCase,
    this._sendSetFontColorUseCase,
    this._sendSetFontSizeUseCase,
    this._sendSetLineHeightUseCase,
    this._sendSetSmoothScrollUseCase,
    this._getBookUseCase,
    this._webViewController,
    this._webViewRepository,
    this._searchRepository,
    this.searchCubit,
  ) : super(const ReaderState());

  Book? bookData;
  late ThemeData currentTheme;

  late final ReaderWebViewHandler webViewHandler;
  final ReaderSearchCubit searchCubit;
  late final ReaderTTSHandler ttsHandler;

  late final ReaderGestureHandler gestureHandler =
      ReaderGestureHandler(onSwipeLeft: previousPage, onSwipeRight: nextPage);
  late final AppLifecycleListener _lifecycle =
      AppLifecycleListener(onStateChange: _onLifecycleChanged);

  /// Dependencies
  final WebViewController _webViewController;
  final ReaderWebViewRepository _webViewRepository;
  final ReaderSearchRepository _searchRepository;

  /// Stream Subscriptions
  late final StreamSubscription<String> _saveLocationStreamSubscription;
  late final StreamSubscription<void> _loadDoneStreamSubscription;
  late final StreamSubscription<ReaderSetStateData> _setStateStreamSubscription;

  /// Use cases
  final ReaderStartReaderServerUseCase _startReaderServerUseCase;
  final ReaderStopReaderServerUseCase _stopReaderServerUseCase;
  final GetBookUseCase _getBookUseCase;
  final ReaderObserveSaveLocationUseCase _observeSaveLocationUseCase;
  final ReaderObserveLoadDoneUseCase _observeLoadDoneUseCase;
  final ReaderObserveSetStateUseCase _observeSetStateUseCase;
  final ReaderSendPreviousPageUseCase _sendPreviousPageUseCase;
  final ReaderSendNextPageUseCase _sendNextPageUseCase;
  final ReaderSendSetFontColorUseCase _sendSetFontColorUseCase;
  final ReaderSendSetFontSizeUseCase _sendSetFontSizeUseCase;
  final ReaderSendSetLineHeightUseCase _sendSetLineHeightUseCase;
  final ReaderSendSetSmoothScrollUseCase _sendSetSmoothScrollUseCase;

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
      _getBookUseCase(bookIdentifier)
          .then((Book value) => this.bookData = value),
      PreferenceService.reader
          .load()
          .then((ReaderPreferenceData value) => readerSettingsData = value),
      BookmarkService.repository
          .get(bookIdentifier)
          .then((BookmarkData? data) => bookmarkData = data),
    ]);

    // Start back-end server
    final Uri serverUri = await _startReaderServerUseCase(bookIdentifier);

    // Initialize webview handler
    webViewHandler = ReaderWebViewHandler(
      controller: _webViewController,
      repository: _webViewRepository,
      uri: serverUri,
      destination: destinationType == ReaderDestinationType.bookmark
          ? bookmarkData?.startCfi ?? destination
          : destination,
      savedLocation: await LocationCacheRepository.get(bookIdentifier),
    );

    // Listen messages
    _saveLocationStreamSubscription =
        _observeSaveLocationUseCase().listen(_receiveSaveLocation);
    _loadDoneStreamSubscription =
        _observeLoadDoneUseCase().listen(_receiveLoadDone);
    _setStateStreamSubscription =
        _observeSetStateUseCase().listen(_receiveSetState);

    // Initialize TTS handler
    ttsHandler = ReaderTTSHandler(
      webViewHandler: webViewHandler,
      onTtsStateChanged: _onTtsStateChanged,
    );

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
    sendThemeData();
  }

  set lineHeight(double value) {
    emit(state.copyWith(
      readerPreference: state.readerPreference.copyWith(
        lineHeight: value,
      ),
    ));
    sendThemeData();
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

  void saveSettings() => PreferenceService.reader.save(state.readerPreference);

  Future<void> resetSettings() async {
    await PreferenceService.reader.reset();
    emit(state.copyWith(
      readerPreference: await PreferenceService.reader.load(),
    ));
    sendThemeData();
  }

  /// *************************************************************************
  /// Bookmarks
  /// *************************************************************************

  void saveBookmark() {
    final BookmarkData data = BookmarkData(
      bookPath: bookData!.identifier,
      bookName: state.bookName,
      chapterTitle: state.breadcrumb,
      chapterFileName: state.chapterFileName,
      startCfi: state.startCfi,
      savedTime: DateTime.now(),
    );

    BookmarkService.repository.updateData(<BookmarkData>{data});

    emit(state.copyWith(bookmarkData: data));
  }

  /// *************************************************************************
  /// Page Navigation
  /// *************************************************************************

  void previousPage() {
    if (state.ttsState.isStopped) {
      _sendPreviousPageUseCase();
    }
  }

  void nextPage() {
    if (state.ttsState.isStopped) {
      _sendNextPageUseCase();
    }
  }

  /// *************************************************************************
  /// TTS
  /// *************************************************************************

  void _onTtsStateChanged(TtsServiceState ttsState) {
    if (!isClosed) {
      emit(state.copyWith(ttsState: ttsState));
    }
  }

  /// *************************************************************************
  /// Lifecycle
  /// *************************************************************************

  void _onLifecycleChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        _stopReaderServerUseCase();
        break;
      default:
    }
  }

  /// *************************************************************************
  /// Communication
  /// *************************************************************************

  void _receiveSaveLocation(String data) {
    if (bookData != null) {
      LocationCacheRepository.store(bookData!.identifier, data);
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
    _lifecycle.dispose();
    await _saveLocationStreamSubscription.cancel();
    await _loadDoneStreamSubscription.cancel();
    await _setStateStreamSubscription.cancel();
    await _stopReaderServerUseCase();
    await _webViewRepository.dispose();
    await _searchRepository.dispose();
    await searchCubit.close();
    await ttsHandler.dispose();
    super.close();
  }
}
