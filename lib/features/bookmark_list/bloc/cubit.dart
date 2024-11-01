part of '../bookmark_list.dart';

// The BookmarkListCubit class manages the state of the bookmark list.
class BookmarkListCubit extends Cubit<CommonListState<BookmarkData>> {
  final String _sortOrderPrefKey = PreferenceKeys.bookmark.sortOrder;
  final String _ascendingPrefKey = PreferenceKeys.bookmark.isAscending;

  // Constructor initializes the state with default values.
  BookmarkListCubit() : super(const CommonListState<BookmarkData>());

  // Refreshes the bookmark list by fetching it from the data source and sorting it.
  void refresh() async {
    // Fetch the bookmark list from the data source.
    final bookmarkList = BookmarkRepository.getList();

    // Fetch the preference.
    final prefs = await SharedPreferences.getInstance();
    final sortOrder = SortOrderCode.fromString(
      prefs.getString(_sortOrderPrefKey),
      defaultValue: SortOrderCode.savedTime,
    );
    final isAscending = prefs.getBool(_ascendingPrefKey) ?? false;
    _sortList(bookmarkList, sortOrder, isAscending);

    if (!isClosed) {
      emit(CommonListState<BookmarkData>(
        code: LoadingStateCode.loaded,
        sortOrder: sortOrder,
        dataList: bookmarkList,
        isAscending: isAscending,
      ));
    }
  }

  // When move to the other page, reset the dragging and selecting states.
  void unfocused() {
    setSelecting(false);
    setDragging(false);
  }

  // Set the list order
  Future<void> setListOrder({
    SortOrderCode? sortOrder,
    bool? isAscending,
  }) async {
    List<BookmarkData> list = List.from(state.dataList);
    sortOrder ??= state.sortOrder;
    isAscending ??= state.isAscending;

    // Save the sorting preferences.
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_sortOrderPrefKey, sortOrder.toString());
    prefs.setBool(_ascendingPrefKey, isAscending);

    _sortList(list, sortOrder, isAscending);

    if (!isClosed) {
      emit(state.copyWith(
        dataList: list,
        isAscending: isAscending,
        sortOrder: sortOrder,
      ));
    }
  }

  // Sorts the bookmark list based on the specified order and ascending/descending preference.
  void _sortList(
    List<BookmarkData> list,
    SortOrderCode sortOrder,
    bool isAscending,
  ) {
    switch (sortOrder) {
      case SortOrderCode.name:
        list.sort((a, b) => isAscending
            ? compareNatural(a.bookPath, b.bookPath)
            : compareNatural(b.bookPath, a.bookPath));
        break;

      default:
        list.sort((a, b) => isAscending
            ? a.savedTime.compareTo(b.savedTime)
            : b.savedTime.compareTo(a.savedTime));
        break;
    }
  }

  void setSelecting(bool isSelecting) {
    emit(state.copyWith(isSelecting: isSelecting, selectedSet: const {}));
  }

  void setDragging(bool isDragging) {
    emit(state.copyWith(isDragging: isDragging));
  }

  // Selects a specific bookmark and updates the state.
  void selectBookmark(BookmarkData data) {
    emit(state.copyWith(
      selectedSet: {
        ...state.selectedSet,
        data,
      },
    ));
  }

  // Selects all bookmarks and updates the state.
  void selectAllBookmarks() {
    emit(state.copyWith(
      selectedSet: state.dataList.toSet(),
    ));
  }

  // Deselects a specific bookmark and updates the state.
  void deselectBookmark(BookmarkData data) {
    Set<BookmarkData> newSet = Set<BookmarkData>.from(state.selectedSet);
    newSet.remove(data);

    emit(state.copyWith(
      selectedSet: newSet,
    ));
  }

  // Deselects all bookmarks and updates the state.
  void deselectAllBookmarks() {
    emit(state.copyWith(
      selectedSet: const {},
    ));
  }

  // Deletes the selected bookmarks and refreshes the list.
  bool deleteSelectedBookmarks() {
    for (final data in state.selectedSet) {
      BookmarkRepository.delete(data);
    }
    refresh();
    return true;
  }
}
