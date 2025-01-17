part of '../bookmark_list.dart';

typedef _State = CommonListState<BookmarkData>;

// The BookmarkListCubit class manages the state of the bookmark list.
class BookmarkListCubit extends CommonListCubit<BookmarkData> {
  final String _sortOrderPrefKey = PreferenceKeys.bookmark.sortOrder;
  final String _ascendingPrefKey = PreferenceKeys.bookmark.isAscending;

  // Constructor initializes the state with default values.
  BookmarkListCubit() : super(const _State());

  // Refreshes the bookmark list by fetching it from the data source and sorting it.
  @override
  Future<void> refresh() async {
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
      emit(_State(
        code: LoadingStateCode.loaded,
        sortOrder: sortOrder,
        dataList: bookmarkList,
        isAscending: isAscending,
      ));
    }
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

  // Deletes the selected bookmarks and refreshes the list.
  bool deleteSelectedBookmarks() {
    for (final data in state.selectedSet) {
      BookmarkRepository.delete(data);
    }
    refresh();
    return true;
  }
}
