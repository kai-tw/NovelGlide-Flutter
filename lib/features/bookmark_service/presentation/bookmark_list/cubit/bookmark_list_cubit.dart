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
    await BookmarkService.preference.load();

    emit(BookmarkListState(
      code: LoadingStateCode.loaded,
      dataList: List<BookmarkData>.from(state.dataList),
      sortOrder: BookmarkService.preference.sortOrder,
      isAscending: BookmarkService.preference.isAscending,
      listType: BookmarkService.preference.listType,
    ));

    // Load bookmark list.
    final List<BookmarkData> bookmarkList =
        BookmarkService.repository.getList();
    _sortList(bookmarkList, BookmarkService.preference.sortOrder,
        BookmarkService.preference.isAscending);

    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      dataList: bookmarkList,
    ));
  }

  @override
  void setListOrder({SortOrderCode? sortOrder, bool? isAscending}) {
    final List<BookmarkData> list = List<BookmarkData>.from(state.dataList);
    sortOrder ??= state.sortOrder;
    isAscending ??= state.isAscending;

    BookmarkService.preference.sortOrder = sortOrder;
    BookmarkService.preference.isAscending = isAscending;

    _sortList(list, sortOrder, isAscending);

    emit(state.copyWith(
      dataList: list,
      isAscending: isAscending,
      sortOrder: sortOrder,
    ));
  }

  @override
  set listType(SharedListType value) {
    BookmarkService.preference.listType = value;
    super.listType = value;
  }

  void _sortList(
    List<BookmarkData> list,
    SortOrderCode sortOrder,
    bool isAscending,
  ) {
    switch (sortOrder) {
      case SortOrderCode.name:
        list.sort((BookmarkData a, BookmarkData b) => isAscending
            ? compareNatural(a.bookPath, b.bookPath)
            : compareNatural(b.bookPath, a.bookPath));
        break;

      default:
        list.sort((BookmarkData a, BookmarkData b) => isAscending
            ? a.savedTime.compareTo(b.savedTime)
            : b.savedTime.compareTo(a.savedTime));
        break;
    }
  }

  bool deleteSelectedBookmarks() {
    state.selectedSet.forEach(BookmarkService.repository.delete);
    refresh();
    return true;
  }
}
