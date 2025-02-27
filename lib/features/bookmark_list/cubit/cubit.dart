import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data_model/bookmark_data.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/sort_order_code.dart';
import '../../../preference_keys/preference_keys.dart';
import '../../../repository/bookmark_repository.dart';
import '../../common_components/common_list/list_template.dart';

class BookmarkListCubit extends CommonListCubit<BookmarkData> {
  final _sortOrderPrefKey = PreferenceKeys.bookmark.sortOrder;
  final _ascendingPrefKey = PreferenceKeys.bookmark.isAscending;
  late final SharedPreferences _prefs;

  factory BookmarkListCubit() {
    final instance = BookmarkListCubit._();
    instance._init();
    return instance;
  }

  BookmarkListCubit._() : super(const CommonListState<BookmarkData>());

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> refresh() async {
    final bookmarkList = BookmarkRepository.getList();

    final sortOrder =
        SortOrderCode.fromString(_prefs.getString(_sortOrderPrefKey)) ??
            SortOrderCode.savedTime;
    final isAscending = _prefs.getBool(_ascendingPrefKey) ?? false;
    _sortList(bookmarkList, sortOrder, isAscending);

    emit(CommonListState<BookmarkData>(
      code: LoadingStateCode.loaded,
      sortOrder: sortOrder,
      dataList: bookmarkList,
      isAscending: isAscending,
    ));
  }

  void setListOrder({SortOrderCode? sortOrder, bool? isAscending}) {
    List<BookmarkData> list = List.from(state.dataList);
    sortOrder ??= state.sortOrder;
    isAscending ??= state.isAscending;

    _prefs.setString(_sortOrderPrefKey, sortOrder.toString());
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

  bool deleteSelectedBookmarks() {
    for (final data in state.selectedSet) {
      BookmarkRepository.delete(data);
    }
    refresh();
    return true;
  }
}
