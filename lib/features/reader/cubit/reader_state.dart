part of 'reader_cubit.dart';

class ReaderState extends Equatable {
  final LoadingStateCode code;
  final ReaderLoadingStateCode loadingStateCode;
  final String bookName;
  final String breadcrumb;
  final String chapterFileName;
  final String startCfi;
  final bool atStart;
  final bool atEnd;
  final bool isRtl;
  final int chapterCurrentPage;
  final int chapterTotalPage;
  final ReaderNavigationStateCode navigationStateCode;

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
        atStart,
        atEnd,
        isRtl,
        chapterCurrentPage,
        chapterTotalPage,
        navigationStateCode,
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
    this.atStart = true,
    this.atEnd = false,
    this.isRtl = false,
    this.chapterCurrentPage = 0,
    this.chapterTotalPage = 0,
    this.navigationStateCode = ReaderNavigationStateCode.defaultState,
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
    bool? atStart,
    bool? atEnd,
    bool? isRtl,
    double? percentage,
    int? chapterCurrentPage,
    int? chapterTotalPage,
    ReaderNavigationStateCode? navigationStateCode,
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
      atStart: atStart ?? this.atStart,
      atEnd: atEnd ?? this.atEnd,
      isRtl: isRtl ?? this.isRtl,
      chapterCurrentPage: chapterCurrentPage ?? this.chapterCurrentPage,
      chapterTotalPage: chapterTotalPage ?? this.chapterTotalPage,
      navigationStateCode: navigationStateCode ?? this.navigationStateCode,
      webResourceError: webResourceError ?? this.webResourceError,
      httpResponseError: httpResponseError ?? this.httpResponseError,
      bookmarkData: bookmarkData ?? this.bookmarkData,
      readerSettings: readerSettings ?? this.readerSettings,
    );
  }
}
