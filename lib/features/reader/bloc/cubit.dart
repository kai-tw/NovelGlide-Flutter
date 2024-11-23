part of '../reader.dart';

class ReaderCubit extends Cubit<ReaderState> {
  /// Reader
  final String bookPath;
  BookData? bookData;
  ThemeData currentTheme;

  late final _ServerHandler _serverHandler = _ServerHandler(bookPath, _logger);
  late final _WebViewHandler _webViewHandler = _WebViewHandler(this, _logger);
  late final SearchCubit searchCubit = SearchCubit(this, _logger);
  late final _GestureHandler _gestureHandler = _GestureHandler(this);
  late final _LifecycleHandler _lifecycleHandler = _LifecycleHandler(this);
  final Logger _logger = Logger();

  factory ReaderCubit({
    required String bookPath,
    required ThemeData currentTheme,
    BookData? bookData,
    String? destination,
    bool isGotoBookmark = false,
  }) {
    final initialState = ReaderState(
      bookName: bookData?.name ?? '',
      readerSettings: const ReaderSettingsData(),
    );
    final cubit = ReaderCubit._internal(
      initialState,
      currentTheme: currentTheme,
      bookPath: BookRepository.getAbsolutePath(bookPath),
      bookData: bookData,
    );
    cubit._initialize(destination: destination, isGotoBookmark: isGotoBookmark);
    return cubit;
  }

  ReaderCubit._internal(
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
    final absolutePath = BookRepository.getAbsolutePath(bookPath);
    bookData ??= await BookRepository.get(absolutePath);

    final newState = state.copyWith(
      loadingStateCode: ReaderLoadingStateCode.rendering,
      bookName: bookData?.name,
      bookmarkData: BookmarkRepository.get(bookPath),
      readerSettings: await ReaderSettingsData.load(),
    );

    if (!isClosed) {
      emit(newState);
    }

    _webViewHandler.initialize(
      destination: isGotoBookmark
          ? newState.bookmarkData?.startCfi ?? destination
          : destination,
      savedLocation: CacheRepository.getLocation(bookPath),
    );

    await Future.wait([
      _serverHandler.start(),
      _webViewHandler.addAppApiChannel(),
    ]);
    _webViewHandler.request();
  }

  /// JavaScript Channel Message Processor
  void onAppApiMessage(JavaScriptMessage message) {
    final request = jsonDecode(message.message);
    _logger.i('JS Channel Receive the ${request['route']} request.');

    switch (request['route']) {
      case 'saveLocation':
        if (bookData != null) {
          CacheRepository.storeLocation(bookPath, request['data']);
        }
        break;

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
              breadcrumb: jsonValue['breadcrumb'],
              chapterFileName: jsonValue['chapterFileName'],
              isRtl: jsonValue['isRtl'],
              startCfi: jsonValue['startCfi'],
              chapterCurrentPage:
                  IntUtils.parse(jsonValue['chapterCurrentPage']),
              chapterTotalPage: IntUtils.parse(jsonValue['chapterTotalPage']),
            ),
          );

          if (state.readerSettings.autoSave) {
            saveBookmark();
          }
        }
        break;

      case 'setSearchResultList':
        final Map<String, dynamic> jsonValue = request['data'];
        searchCubit.setResultList(jsonValue['searchResultList']);
        break;

      case 'log':
        _logger.i(request['data']);
        break;

      default:
        _logger.i('Unknown app api message.');
    }
  }

  /// ******* Communication ********

  void prevPage() => _webViewHandler.prevPage();

  void nextPage() => _webViewHandler.nextPage();

  void goto(String cfi) => _webViewHandler.goto(cfi);

  void sendThemeData([ThemeData? newTheme]) {
    currentTheme = newTheme ?? currentTheme;
    if (state.code.isLoaded) {
      _webViewHandler.sendThemeData(currentTheme, state.readerSettings);
    }
  }

  void searchInWholeBook(String query) =>
      _webViewHandler.searchInWholeBook(query);

  void searchInCurrentChapter(String query) =>
      _webViewHandler.searchInCurrentChapter(query);

  void setSmoothScroll(bool isSmoothScroll) =>
      _webViewHandler.setSmoothScroll(isSmoothScroll);

  /// ******* Settings ********

  void setSettings({
    double? fontSize,
    double? lineHeight,
    bool? autoSave,
    bool? gestureDetection,
    bool? isSmoothScroll,
    ReaderSettingsPageNumType? pageNumType,
  }) {
    final settings = state.readerSettings.copyWith(
      fontSize: fontSize,
      lineHeight: lineHeight,
      autoSave: autoSave,
      gestureDetection: gestureDetection,
      isSmoothScroll: isSmoothScroll,
      pageNumType: pageNumType,
    );

    emit(state.copyWith(readerSettings: settings));

    if (fontSize != null || lineHeight != null) {
      sendThemeData();
    }

    if (autoSave == true) {
      saveBookmark();
    }

    if (isSmoothScroll != null) {
      setSmoothScroll(isSmoothScroll);
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
    final data = BookmarkData(
      bookPath: bookPath,
      bookName: state.bookName,
      chapterTitle: state.breadcrumb,
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
    await searchCubit.close();
    _logger.close();
    _lifecycleHandler.dispose();
    super.close();
  }
}
