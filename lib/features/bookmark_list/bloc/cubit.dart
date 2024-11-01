part of '../bookmark_list.dart';

// The BookmarkListCubit class manages the state of the bookmark list.
class BookmarkListCubit extends Cubit<_State> {
  final String _sortOrderPrefKey = PreferenceKeys.bookmark.sortOrder;
  final String _ascendingPrefKey = PreferenceKeys.bookmark.isAscending;

  // Constructor initializes the state with default values.
  BookmarkListCubit() : super(const _State());

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
      emit(_State(
        code: LoadingStateCode.loaded,
        sortOrder: sortOrder,
        bookmarkList: bookmarkList,
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
    List<BookmarkData> list = List.from(state.bookmarkList);
    sortOrder ??= state.sortOrder;
    isAscending ??= state.isAscending;

    // Save the sorting preferences.
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_sortOrderPrefKey, sortOrder.toString());
    prefs.setBool(_ascendingPrefKey, isAscending);

    _sortList(list, sortOrder, isAscending);

    if (!isClosed) {
      emit(state.copyWith(
        bookmarkList: list,
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
    emit(state.copyWith(isSelecting: isSelecting, selectedBookmarks: const {}));
  }

  void setDragging(bool isDragging) {
    emit(state.copyWith(isDragging: isDragging));
  }

  // Selects a specific bookmark and updates the state.
  void selectBookmark(BookmarkData data) {
    emit(state.copyWith(
      selectedBookmarks: {
        ...state.selectedBookmarks,
        data,
      },
    ));
  }

  // Selects all bookmarks and updates the state.
  void selectAllBookmarks() {
    emit(state.copyWith(
      selectedBookmarks: state.bookmarkList.toSet(),
    ));
  }

  // Deselects a specific bookmark and updates the state.
  void deselectBookmark(BookmarkData data) {
    Set<BookmarkData> newSet = Set<BookmarkData>.from(state.selectedBookmarks);
    newSet.remove(data);

    emit(state.copyWith(
      selectedBookmarks: newSet,
    ));
  }

  // Deselects all bookmarks and updates the state.
  void deselectAllBookmarks() {
    emit(state.copyWith(
      selectedBookmarks: const {},
    ));
  }

  // Deletes the selected bookmarks and refreshes the list.
  bool deleteSelectedBookmarks() {
    for (final data in state.selectedBookmarks) {
      BookmarkRepository.delete(data);
    }
    refresh();
    return true;
  }
}

// The BookmarkListState class represents the state of the bookmark list.
class _State extends Equatable {
  final LoadingStateCode code;
  final SortOrderCode sortOrder;
  final List<BookmarkData> bookmarkList;
  final Set<BookmarkData> selectedBookmarks;
  final bool isDragging;
  final bool isSelecting;
  final bool isAscending;

  @override
  List<Object?> get props => [
        code,
        sortOrder,
        bookmarkList,
        selectedBookmarks,
        isDragging,
        isSelecting,
        isAscending
      ];

  // Constructor initializes the state with default values.
  const _State({
    this.code = LoadingStateCode.initial,
    this.sortOrder = SortOrderCode.savedTime,
    this.bookmarkList = const [],
    this.selectedBookmarks = const {},
    this.isDragging = false,
    this.isSelecting = false,
    this.isAscending = false,
  });

  // Creates a copy of the current state with updated properties.
  _State copyWith({
    LoadingStateCode? code,
    SortOrderCode? sortOrder,
    List<BookmarkData>? bookmarkList,
    Set<BookmarkData>? selectedBookmarks,
    bool? isDragging,
    bool? isSelecting,
    bool? isAscending,
  }) {
    return _State(
      code: code ?? this.code,
      sortOrder: sortOrder ?? this.sortOrder,
      bookmarkList: bookmarkList ?? this.bookmarkList,
      selectedBookmarks: selectedBookmarks ?? this.selectedBookmarks,
      isDragging: isDragging ?? this.isDragging,
      isSelecting: isSelecting ?? this.isSelecting,
      isAscending: isAscending ?? this.isAscending,
    );
  }
}
