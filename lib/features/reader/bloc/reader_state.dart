import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/reader_settings_data.dart';

class ReaderState extends Equatable {
  /// Overall state.
  final ReaderStateCode code;
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
  List<Object?> get props =>
      [
        code,
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

  const ReaderState({
    this.code = ReaderStateCode.loading,
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

  ReaderState copyWith({
    ReaderStateCode? code,
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
    return ReaderState(
      code: code ?? this.code,
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

enum ReaderStateCode { loading, loaded, search }
