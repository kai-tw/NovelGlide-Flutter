import 'package:equatable/equatable.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/reader_settings_data.dart';

enum ReaderStateCode { loading, loaded }

class ReaderState extends Equatable {
  /// Overall state.
  final ReaderStateCode code;
  final String bookName;
  final bool atStart;
  final bool atEnd;

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
        bookmarkData,
        readerSettings,
      ];

  const ReaderState({
    this.code = ReaderStateCode.loading,
    required this.bookName,
    this.atStart = true,
    this.atEnd = false,
    this.bookmarkData,
    ReaderSettingsData? readerSettings,
  }) : readerSettings = readerSettings ?? const ReaderSettingsData();

  ReaderState copyWith({
    ReaderStateCode? code,
    String? bookName,
    bool? atStart,
    bool? atEnd,
    BookmarkData? bookmarkData,
    ReaderSettingsData? readerSettings,
  }) {
    return ReaderState(
      code: code ?? this.code,
      bookName: bookName ?? this.bookName,
      atStart: atStart ?? this.atStart,
      atEnd: atEnd ?? this.atEnd,
      bookmarkData: bookmarkData ?? this.bookmarkData,
      readerSettings: readerSettings ?? this.readerSettings,
    );
  }

}
