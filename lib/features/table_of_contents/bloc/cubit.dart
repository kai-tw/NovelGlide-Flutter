part of '../table_of_contents.dart';

class _Cubit extends Cubit<_State> {
  final PageStorageBucket bucket = PageStorageBucket();
  final ScrollController scrollController = ScrollController();
  BookData bookData;

  _Cubit(this.bookData) : super(const _State());

  Future<void> init() async {
    emit(const _State(code: LoadingStateCode.loading));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      emit(_State(
        code: LoadingStateCode.loaded,
        bookmarkData: BookmarkRepository.get(bookData.filePath),
        chapterList: await bookData.getChapterList(),
      ));
    });
  }

  void refresh() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      emit(_State(
        code: LoadingStateCode.loaded,
        bookmarkData: BookmarkRepository.get(bookData.filePath),
        chapterList: state.chapterList,
      ));
    });
  }
}

class _State extends Equatable {
  final LoadingStateCode code;
  final BookmarkData? bookmarkData;
  final List<ChapterData> chapterList;

  @override
  List<Object?> get props => [code, bookmarkData, chapterList];

  const _State({
    this.code = LoadingStateCode.initial,
    this.bookmarkData,
    this.chapterList = const [],
  });
}
