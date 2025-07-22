part of '../../../bookmark_service.dart';

typedef BookmarkListState = SharedListState<BookmarkData>;

class BookmarkListCubit extends SharedListCubit<BookmarkData> {
  factory BookmarkListCubit() {
    final BookmarkListCubit cubit = BookmarkListCubit._();
    WidgetsBinding.instance.addPostFrameCallback((_) => cubit.refresh());
    return cubit;
  }

  BookmarkListCubit._() : super(const SharedListState<BookmarkData>());

  @override
  Future<void> refresh() async {
    if (state.code.isLoading || state.code.isBackgroundLoading) {
      return;
    }

    // Load preferences.
    final SharedListData preference =
        await BookmarkService.preference.list.load();

    // Load bookmark list.
    emit(BookmarkListState(
      code: LoadingStateCode.loaded,
      dataList: sortList(
        BookmarkService.repository.getList(),
        preference.sortOrder,
        preference.isAscending,
      ),
      sortOrder: preference.sortOrder,
      isAscending: preference.isAscending,
      listType: preference.listType,
    ));
  }

  bool deleteSelectedBookmarks() {
    state.selectedSet.forEach(BookmarkService.repository.delete);
    refresh();
    return true;
  }

  @override
  int sortCompare(
    BookmarkData a,
    BookmarkData b, {
    required SortOrderCode sortOrder,
    required bool isAscending,
  }) {
    switch (sortOrder) {
      case SortOrderCode.name:
        return isAscending
            ? compareNatural(a.bookPath, b.bookPath)
            : compareNatural(b.bookPath, a.bookPath);

      default:
        return isAscending
            ? a.savedTime.compareTo(b.savedTime)
            : b.savedTime.compareTo(a.savedTime);
    }
  }

  @override
  void savePreference() {
    BookmarkService.preference.list.save(SharedListData(
      sortOrder: state.sortOrder,
      isAscending: state.isAscending,
      listType: state.listType,
    ));
  }
}
