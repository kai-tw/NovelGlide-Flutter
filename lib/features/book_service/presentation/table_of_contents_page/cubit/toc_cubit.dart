part of '../table_of_contents.dart';

class TocCubit extends Cubit<TocState> {
  factory TocCubit(BookData bookData) {
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
  final BookData bookData;
  late final StreamSubscription<void> _onChangedSubscription;

  Future<void> refresh() async {
    // Start loading
    emit(const TocState(code: LoadingStateCode.loading));

    // Get bookmark data
    final BookmarkData? bookmarkData =
        await BookmarkService.repository.get(bookData.absoluteFilePath);

    // Get chapter list
    final List<ChapterData> chapterList = await bookData.chapterList;

    // Finish loading
    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      bookmarkData: bookmarkData,
      chapterList: chapterList,
    ));
  }

  @override
  Future<void> close() {
    _onChangedSubscription.cancel();
    return super.close();
  }
}
