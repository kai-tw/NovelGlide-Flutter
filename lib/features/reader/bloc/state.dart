part of '../reader.dart';

class _ReaderState extends Equatable {
  final LoadingStateCode code;
  final ReaderLoadingStateCode loadingStateCode;
  final String bookName;
  final String chapterTitle;
  final String chapterFileName;
  final String startCfi;
  final bool atStart;
  final bool atEnd;
  final bool isRtl;
  final int localCurrent;
  final int localTotal;

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
        chapterTitle,
        chapterFileName,
        atStart,
        atEnd,
        isRtl,
        localCurrent,
        localTotal,
        webResourceError,
        httpResponseError,
        bookmarkData,
        readerSettings,
      ];

  const _ReaderState({
    this.code = LoadingStateCode.initial,
    this.loadingStateCode = ReaderLoadingStateCode.initial,
    required this.bookName,
    this.chapterTitle = '',
    this.chapterFileName = '',
    this.startCfi = '',
    this.atStart = true,
    this.atEnd = false,
    this.isRtl = false,
    this.localCurrent = 0,
    this.localTotal = 0,
    this.webResourceError,
    this.httpResponseError,
    this.bookmarkData,
    required this.readerSettings,
  });

  _ReaderState copyWith({
    LoadingStateCode? code,
    ReaderLoadingStateCode? loadingStateCode,
    String? bookName,
    String? chapterTitle,
    String? chapterFileName,
    String? startCfi,
    bool? atStart,
    bool? atEnd,
    bool? isRtl,
    int? localCurrent,
    int? localTotal,
    WebResourceError? webResourceError,
    HttpResponseError? httpResponseError,
    BookmarkData? bookmarkData,
    ReaderSettingsData? readerSettings,
  }) {
    return _ReaderState(
      code: code ?? this.code,
      loadingStateCode: loadingStateCode ?? this.loadingStateCode,
      bookName: bookName ?? this.bookName,
      chapterTitle: chapterTitle ?? this.chapterTitle,
      chapterFileName: chapterFileName ?? this.chapterFileName,
      startCfi: startCfi ?? this.startCfi,
      atStart: atStart ?? this.atStart,
      atEnd: atEnd ?? this.atEnd,
      isRtl: isRtl ?? this.isRtl,
      localCurrent: localCurrent ?? this.localCurrent,
      localTotal: localTotal ?? this.localTotal,
      webResourceError: webResourceError ?? this.webResourceError,
      httpResponseError: httpResponseError ?? this.httpResponseError,
      bookmarkData: bookmarkData ?? this.bookmarkData,
      readerSettings: readerSettings ?? this.readerSettings,
    );
  }
}

enum ReaderLoadingStateCode { initial, bookLoading, rendering }
