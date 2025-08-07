part of '../table_of_contents.dart';

class TocCubit extends Cubit<TocState> {
  factory TocCubit(Book bookData) {
    final TocCubit cubit = TocCubit._(bookData);

    // Refresh at first
    cubit.refresh();

    // Listen to bookmarks changes.
    cubit._onChangedSubscription = BookmarkService
        .repository.onChangedController.stream
        .listen((_) => cubit.refresh());

    return cubit;
  }

  TocCubit._(this.bookData) : super(const TocState());

  final PageStorageBucket bucket = PageStorageBucket();
  final ScrollController scrollController = ScrollController();
  final Book bookData;
  late final StreamSubscription<void> _onChangedSubscription;

  Future<void> refresh() async {
    // Start loading
    emit(const TocState(code: LoadingStateCode.loading));

    // Get bookmark data
    final BookmarkData? bookmarkData =
        await BookmarkService.repository.get(bookData.identifier);

    // Finish loading
    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      bookmarkData: bookmarkData,
      chapterList: bookData.chapterList,
    ));
  }

  /// Constructs the chapter n-ary tree.
  /// Driver function.
  List<TocNestedChapterData> constructChapterTree() =>
      _constructChapterTree(bookData.chapterList, 0);

  /// Constructs the chapter n-ary tree.
  /// [chapterDataList] is the list of chapters to be traversed.
  /// [nestedLevel] is the nesting level of the current chapter.
  /// [nestedLevel] will be used to calculate the indentation of the chapter tile.
  List<TocNestedChapterData> _constructChapterTree(
    List<BookChapter> chapterDataList,
    int nestedLevel,
  ) {
    // Tree root
    final List<TocNestedChapterData> list = <TocNestedChapterData>[];

    // Traverse the sub chapters
    for (final BookChapter data in chapterDataList) {
      list.add(TocNestedChapterData(
        chapterData: data,
        nestedLevel: nestedLevel,
      ));

      // If the chapter has sub chapters, traverse them
      if (data.subChapterList.isNotEmpty) {
        list.addAll(
          _constructChapterTree(data.subChapterList, nestedLevel + 1),
        );
      }
    }
    return list;
  }

  @override
  Future<void> close() {
    _onChangedSubscription.cancel();
    return super.close();
  }
}
