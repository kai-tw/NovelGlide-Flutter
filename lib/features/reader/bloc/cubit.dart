part of '../reader.dart';

class _ReaderCubit extends Cubit<_ReaderState> {
  /// Reader
  final String bookPath;
  BookData? bookData;
  ThemeData currentTheme;

  late final _ServerHandler _serverHandler = _ServerHandler(bookPath, _logger);
  late final _WebViewHandler _webViewHandler = _WebViewHandler(this, _logger);
  late final _SearchCubit _searchCubit = _SearchCubit(this, _logger);
  late final _GestureHandler _gestureHandler = _GestureHandler(this);
  late final _LifecycleHandler _lifecycleHandler = _LifecycleHandler(this);
  final Logger _logger = Logger();

  factory _ReaderCubit({
    required String bookPath,
    required ThemeData currentTheme,
    BookData? bookData,
    String? destination,
    bool isGotoBookmark = false,
  }) {
    final initialState = _ReaderState(
      bookName: bookData?.name ?? '',
      readerSettings: const ReaderSettingsData(),
    );
    final cubit = _ReaderCubit._internal(
      initialState,
      currentTheme: currentTheme,
      bookPath: BookRepository.getBookAbsolutePath(bookPath),
      bookData: bookData,
    );
    cubit._initialize(destination: destination, isGotoBookmark: isGotoBookmark);
    return cubit;
  }

  _ReaderCubit._internal(
    super.initialState, {
    required this.currentTheme,
    required this.bookPath,
    this.bookData,
  });

  /// Client initialization.
  Future<void> _initialize({
    String? destination,
    bool isGotoBookmark = false,
  }) async {
    emit(state.copyWith(
      code: LoadingStateCode.loading,
      loadingStateCode: ReaderLoadingStateCode.bookLoading,
    ));

    /// Read the book if it is not read yet.
    if (bookData == null) {
      final absolutePath = BookRepository.getBookAbsolutePath(bookPath);
      final epubBook = await EpubUtils.loadEpubBook(absolutePath);
      bookData = BookData.fromEpubBook(absolutePath, epubBook);
    }

    if (!isClosed) {
      emit(state.copyWith(
        loadingStateCode: ReaderLoadingStateCode.rendering,
        bookName: bookData?.name,
        bookmarkData: BookmarkRepository.get(bookPath),
        readerSettings: await ReaderSettingsData.load(),
      ));
    }

    _webViewHandler.initialize(
      destination: destination,
      isGotoBookmark: isGotoBookmark,
    );

    await Future.wait([
      _serverHandler.start(),
      _webViewHandler.addAppApiChannel(),
    ]);
    _webViewHandler.request();
  }

  /// JavaScript Channel Message Processor
  void onAppApiMessage(JavaScriptMessage message) async {
    Map<String, dynamic> request = jsonDecode(message.message);
    _logger.i('JS Channel Receive the ${request['route']} request.');

    switch (request['route']) {
      case 'loadDone':
        if (!isClosed) {
          _logger.i('The book has been loaded.');
          _serverHandler.stop();
          emit(state.copyWith(code: LoadingStateCode.loaded));
          sendThemeData();
        }
        break;

      case 'setState':
        if (!isClosed) {
          final Map<String, dynamic> jsonValue = request['data'];
          emit(
            state.copyWith(
              atStart: jsonValue['atStart'],
              atEnd: jsonValue['atEnd'],
              chapterFileName: jsonValue['href'],
              isRtl: jsonValue['isRtl'],
              startCfi: jsonValue['startCfi'],
              localCurrent: jsonValue['localCurrent'],
              localTotal: jsonValue['localTotal'],
            ),
          );

          if (jsonValue['searchResultList'] is List) {
            _searchCubit.setResultList(
              jsonValue['searchResultList']
                  .map<_SearchResult>(
                    (e) => _SearchResult(
                      cfi: e['cfi'],
                      excerpt: e['excerpt'],
                    ),
                  )
                  .toList(),
            );
          }

          if (state.readerSettings.autoSave) {
            saveBookmark();
          }
        }
        break;

      case 'log':
        _logger.i(request['data']);
        break;

      default:
        _logger.i('Unknown app api message: $message.');
    }
  }

  /// ******* Communication ********

  void prevPage() =>
      _webViewHandler.controller.runJavaScript('window.readerApi.prevPage()');

  void nextPage() =>
      _webViewHandler.controller.runJavaScript('window.readerApi.nextPage()');

  void goto(String cfi) =>
      _webViewHandler.controller.runJavaScript('window.readerApi.goto("$cfi")');

  void sendThemeData([ThemeData? newTheme]) {
    currentTheme = newTheme ?? currentTheme;
    if (state.code == LoadingStateCode.loaded) {
      _webViewHandler.sendThemeData(currentTheme, state.readerSettings);
    }
  }

  /// ******* Settings ********

  void setSettings({
    double? fontSize,
    double? lineHeight,
    bool? autoSave,
    bool? gestureDetection,
  }) {
    final settings = state.readerSettings.copyWith(
      fontSize: fontSize,
      lineHeight: lineHeight,
      autoSave: autoSave,
      gestureDetection: gestureDetection,
    );

    emit(state.copyWith(readerSettings: settings));

    if (fontSize != null || lineHeight != null) {
      sendThemeData();
    }

    if (autoSave == true) {
      saveBookmark();
    }
  }

  void saveSettings() => state.readerSettings.save();

  void resetSettings() {
    emit(state.copyWith(readerSettings: const ReaderSettingsData()));
    sendThemeData();
  }

  /// ******* Bookmarks ********

  Future<void> saveBookmark() async {
    _logger.i('Save the bookmark.');
    final chapterList = await bookData?.getChapterList();
    final chapterTitle = BookUtils.getChapterTitleByFileName(
      chapterList,
      state.chapterFileName,
      defaultValue: '-',
    );
    final data = BookmarkData(
      bookPath: bookPath,
      bookName: state.bookName,
      chapterTitle: chapterTitle,
      chapterFileName: state.chapterFileName,
      startCfi: state.startCfi,
      savedTime: DateTime.now(),
    );

    BookmarkRepository.save(data);

    if (!isClosed) {
      emit(state.copyWith(bookmarkData: data));
    }
  }

  void scrollToBookmark() {
    _logger.i('Scroll to the bookmark.');
    final bookmarkData =
        state.bookmarkData ?? BookmarkRepository.get(state.bookName);
    if (bookmarkData?.startCfi != null) {
      goto(bookmarkData!.startCfi!);
    }
  }

  @override
  Future<void> close() async {
    await _serverHandler.stop();
    await _searchCubit.close();
    _logger.close();
    _lifecycleHandler.dispose();
    super.close();
  }
}
