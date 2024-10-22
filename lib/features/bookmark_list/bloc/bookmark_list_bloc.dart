import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/preference_keys.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/sort_order_code.dart';

// The BookmarkListCubit class manages the state of the bookmark list.
class BookmarkListCubit extends Cubit<BookmarkListState> {
  final String _sortOrderPrefKey = PreferenceKeys.bookmark.sortOrder;
  final String _ascendingPrefKey = PreferenceKeys.bookmark.isAscending;

  // Constructor initializes the state with default values.
  BookmarkListCubit() : super(const BookmarkListState());

  // Refreshes the bookmark list by fetching it from the data source and sorting it.
  void refresh() async {
    // Fetch the bookmark list from the data source.
    final List<BookmarkData> bookmarkList = BookmarkData.getList();

    // Fetch the preference.
    final prefs = await SharedPreferences.getInstance();
    final sortOrder = SortOrderCode.fromString(
      prefs.getString(_sortOrderPrefKey),
      defaultValue: SortOrderCode.savedTime,
    );
    final isAscending = prefs.getBool(_ascendingPrefKey) ?? false;
    _sortList(bookmarkList, sortOrder, isAscending);

    if (!isClosed) {
      emit(BookmarkListState(
        code: LoadingStateCode.loaded,
        sortOrder: sortOrder,
        bookmarkList: bookmarkList,
        isAscending: isAscending,
      ));
    }
  }

  // When move to the other page, reset the dragging and selecting states.
  void unfocused() {
    emit(state.copyWith(isDragging: false, isSelecting: false));
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

  // Updates the dragging state and emits the new state.
  set isDragging(bool value) => emit(state.copyWith(isDragging: value));

  // Updates the selecting state and resets selected bookmarks.
  set isSelecting(bool value) => emit(state.copyWith(
        isSelecting: value,
        selectedBookmarks: const {},
      ));

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
  Future<bool> deleteSelectedBookmarks() async {
    await Future.wait(state.selectedBookmarks.map((e) => e.delete()));
    refresh();
    return true;
  }
}

// The BookmarkListState class represents the state of the bookmark list.
class BookmarkListState extends Equatable {
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
  const BookmarkListState({
    this.code = LoadingStateCode.initial,
    this.sortOrder = SortOrderCode.savedTime,
    this.bookmarkList = const [],
    this.selectedBookmarks = const {},
    this.isDragging = false,
    this.isSelecting = false,
    this.isAscending = false,
  });

  // Creates a copy of the current state with updated properties.
  BookmarkListState copyWith({
    LoadingStateCode? code,
    SortOrderCode? sortOrder,
    List<BookmarkData>? bookmarkList,
    Set<BookmarkData>? selectedBookmarks,
    bool? isDragging,
    bool? isSelecting,
    bool? isAscending,
  }) {
    return BookmarkListState(
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
