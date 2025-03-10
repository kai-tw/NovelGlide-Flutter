part of 'reader_cubit.dart';

class ReaderState extends Equatable {
  final LoadingStateCode code;
  final ReaderLoadingStateCode loadingStateCode;
  final String bookName;
  final String breadcrumb;
  final String chapterFileName;
  final String startCfi;
  final int chapterCurrentPage;
  final int chapterTotalPage;
  final ReaderNavigationStateCode navigationStateCode;
  final TtsServiceState ttsState;

  /// Errors
  final WebResourceError? webResourceError;
  final HttpResponseError? httpResponseError;

  /// Bookmark state.
  final BookmarkData? bookmarkData;

  /// Settings state.
  final ReaderSettingsData readerSettings;

  @override
  List<Object?> get props => [
        code,
        loadingStateCode,
        bookName,
        breadcrumb,
        chapterFileName,
        chapterCurrentPage,
        chapterTotalPage,
        navigationStateCode,
        ttsState,
        webResourceError,
        httpResponseError,
        bookmarkData,
        readerSettings,
      ];

  const ReaderState({
    this.code = LoadingStateCode.initial,
    this.loadingStateCode = ReaderLoadingStateCode.initial,
    this.bookName = '',
    this.breadcrumb = '',
    this.chapterFileName = '',
    this.startCfi = '',
    this.chapterCurrentPage = 0,
    this.chapterTotalPage = 0,
    this.navigationStateCode = ReaderNavigationStateCode.defaultState,
    this.ttsState = TtsServiceState.initial,
    this.webResourceError,
    this.httpResponseError,
    this.bookmarkData,
    this.readerSettings = const ReaderSettingsData(),
  });

  ReaderState copyWith({
    LoadingStateCode? code,
    ReaderLoadingStateCode? loadingStateCode,
    String? bookName,
    String? breadcrumb,
    String? chapterFileName,
    String? startCfi,
    double? percentage,
    int? chapterCurrentPage,
    int? chapterTotalPage,
    ReaderNavigationStateCode? navigationStateCode,
    TtsServiceState? ttsState,
    WebResourceError? webResourceError,
    HttpResponseError? httpResponseError,
    BookmarkData? bookmarkData,
    ReaderSettingsData? readerSettings,
  }) {
    return ReaderState(
      code: code ?? this.code,
      loadingStateCode: loadingStateCode ?? this.loadingStateCode,
      bookName: bookName ?? this.bookName,
      breadcrumb: breadcrumb ?? this.breadcrumb,
      chapterFileName: chapterFileName ?? this.chapterFileName,
      startCfi: startCfi ?? this.startCfi,
      chapterCurrentPage: chapterCurrentPage ?? this.chapterCurrentPage,
      chapterTotalPage: chapterTotalPage ?? this.chapterTotalPage,
      navigationStateCode: navigationStateCode ?? this.navigationStateCode,
      ttsState: ttsState ?? this.ttsState,
      webResourceError: webResourceError ?? this.webResourceError,
      httpResponseError: httpResponseError ?? this.httpResponseError,
      bookmarkData: bookmarkData ?? this.bookmarkData,
      readerSettings: readerSettings ?? this.readerSettings,
    );
  }
}
