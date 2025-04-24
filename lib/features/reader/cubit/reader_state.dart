part of 'reader_cubit.dart';

class ReaderState extends Equatable {
  const ReaderState({
    this.code = ReaderLoadingStateCode.initial,
    this.bookName = '',
    this.breadcrumb = '',
    this.chapterFileName = '',
    this.startCfi = '',
    this.chapterCurrentPage = 0,
    this.chapterTotalPage = 0,
    this.navigationStateCode = ReaderNavigationStateCode.defaultState,
    this.ttsState = TtsServiceState.initial,
    this.bookmarkData,
    this.readerSettings = const ReaderSettingsData(),
  });

  final ReaderLoadingStateCode code;

  /// Book state.
  final String bookName;
  final String breadcrumb;
  final String chapterFileName;
  final String startCfi;
  final int chapterCurrentPage;
  final int chapterTotalPage;

  /// Bottom buttons state.
  final ReaderNavigationStateCode navigationStateCode;

  /// TTS state.
  final TtsServiceState ttsState;

  /// Bookmark
  final BookmarkData? bookmarkData;

  /// Settings
  final ReaderSettingsData readerSettings;

  @override
  List<Object?> get props => <Object?>[
        code,
        bookName,
        breadcrumb,
        chapterFileName,
        chapterCurrentPage,
        chapterTotalPage,
        navigationStateCode,
        ttsState,
        bookmarkData,
        readerSettings,
      ];

  ReaderState copyWith({
    ReaderLoadingStateCode? code,
    String? bookName,
    String? breadcrumb,
    String? chapterFileName,
    String? startCfi,
    int? chapterCurrentPage,
    int? chapterTotalPage,
    ReaderNavigationStateCode? navigationStateCode,
    TtsServiceState? ttsState,
    BookmarkData? bookmarkData,
    ReaderSettingsData? readerSettings,
  }) {
    return ReaderState(
      code: code ?? this.code,
      bookName: bookName ?? this.bookName,
      breadcrumb: breadcrumb ?? this.breadcrumb,
      chapterFileName: chapterFileName ?? this.chapterFileName,
      startCfi: startCfi ?? this.startCfi,
      chapterCurrentPage: chapterCurrentPage ?? this.chapterCurrentPage,
      chapterTotalPage: chapterTotalPage ?? this.chapterTotalPage,
      navigationStateCode: navigationStateCode ?? this.navigationStateCode,
      ttsState: ttsState ?? this.ttsState,
      bookmarkData: bookmarkData ?? this.bookmarkData,
      readerSettings: readerSettings ?? this.readerSettings,
    );
  }
}
