part of '../table_of_contents.dart';

class _Cubit extends Cubit<_State> {
  _Cubit(this.bookData) : super(const _State());

  final PageStorageBucket bucket = PageStorageBucket();
  final ScrollController scrollController = ScrollController();
  BookData bookData;

  Future<void> init() async {
    emit(const _State(code: LoadingStateCode.loading));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      emit(_State(
        code: LoadingStateCode.loaded,
        bookmarkData:
            await BookmarkService.repository.get(bookData.absoluteFilePath),
        chapterList: await bookData.chapterList,
      ));
    });
  }

  Future<void> refresh() async {
    emit(_State(
      code: LoadingStateCode.loaded,
      bookmarkData:
          await BookmarkService.repository.get(bookData.absoluteFilePath),
      chapterList: state.chapterList,
    ));
  }
}

class _State extends Equatable {
  const _State({
    this.code = LoadingStateCode.initial,
    this.bookmarkData,
    this.chapterList = const <ChapterData>[],
  });

  final LoadingStateCode code;
  final BookmarkData? bookmarkData;
  final List<ChapterData> chapterList;

  @override
  List<Object?> get props => <Object?>[code, bookmarkData, chapterList];
}
