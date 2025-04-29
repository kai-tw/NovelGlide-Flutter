import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../../../preference_keys/preference_keys.dart';
import '../../../../common_components/common_list/list_template.dart';
import '../../../data/bookmark_data.dart';
import '../../../data/bookmark_repository.dart';

typedef BookmarkListState = CommonListState<BookmarkData>;

class BookmarkListCubit extends CommonListCubit<BookmarkData> {
  factory BookmarkListCubit() {
    final BookmarkListCubit instance = BookmarkListCubit._();
    instance._init();
    return instance;
  }

  BookmarkListCubit._() : super(const CommonListState<BookmarkData>());
  final String _sortOrderPrefKey = PreferenceKeys.bookmark.sortOrder;
  final String _ascendingPrefKey = PreferenceKeys.bookmark.isAscending;
  late final SharedPreferences _prefs;

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> refresh() async {
    // Load preferences.
    int sortOrder;
    try {
      sortOrder = _prefs.getInt(_sortOrderPrefKey) ?? SortOrderCode.name.index;
    } catch (_) {
      sortOrder = SortOrderCode.name.index;
    }
    final SortOrderCode sortOrderCode = SortOrderCode.values[sortOrder];
    final bool isAscending = _prefs.getBool(_ascendingPrefKey) ?? false;

    // Load bookmark list.
    final List<BookmarkData> bookmarkList = BookmarkRepository.getList();
    _sortList(bookmarkList, sortOrderCode, isAscending);

    emit(BookmarkListState(
      code: LoadingStateCode.loaded,
      dataList: bookmarkList,
      isAscending: isAscending,
      sortOrder: sortOrderCode,
    ));
  }

  void setListOrder({SortOrderCode? sortOrder, bool? isAscending}) {
    final List<BookmarkData> list = List<BookmarkData>.from(state.dataList);
    sortOrder ??= state.sortOrder;
    isAscending ??= state.isAscending;

    _prefs.setInt(_sortOrderPrefKey, sortOrder.index);
    _prefs.setBool(_ascendingPrefKey, isAscending);

    _sortList(list, sortOrder, isAscending);

    emit(state.copyWith(
      dataList: list,
      isAscending: isAscending,
      sortOrder: sortOrder,
    ));
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
    state.selectedSet.forEach(BookmarkRepository.delete);
    refresh();
    return true;
  }
}
