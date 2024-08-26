import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/reader_settings_data.dart';

class ReaderState extends Equatable {
  /// Overall state.
  final ReaderStateCode code;
  final String bookName;
  final bool atStart;
  final bool atEnd;
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
        atStart,
        atEnd,
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
    this.atStart = true,
    this.atEnd = false,
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
    bool? atStart,
    bool? atEnd,
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
      atStart: atStart ?? this.atStart,
      atEnd: atEnd ?? this.atEnd,
      localCurrent: localCurrent ?? this.localCurrent,
      localTotal: localTotal ?? this.localTotal,
      webResourceError: webResourceError ?? this.webResourceError,
      httpResponseError: httpResponseError ?? this.httpResponseError,
      bookmarkData: bookmarkData ?? this.bookmarkData,
      readerSettings: readerSettings ?? this.readerSettings,
    );
  }

}

enum ReaderStateCode { loading, loaded, search, webResourceError, httpResponseError }
