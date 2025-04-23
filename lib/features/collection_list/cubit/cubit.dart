import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data_model/collection_data.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/sort_order_code.dart';
import '../../../preference_keys/preference_keys.dart';
import '../../../repository/collection_repository.dart';
import '../../common_components/common_list/list_template.dart';

class CollectionListCubit extends CommonListCubit<CollectionData> {
  final _sortOrderKey = PreferenceKeys.collection.sortOrder;
  final _isAscendingKey = PreferenceKeys.collection.isAscending;
  late final SharedPreferences _prefs;

  factory CollectionListCubit() {
    final cubit =
        CollectionListCubit._(const CommonListState<CollectionData>());
    cubit._init();
    return cubit;
  }

  CollectionListCubit._(super.initialState);

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    refresh();
  }

  @override
  Future<void> refresh() async {
    emit(state.copyWith(code: LoadingStateCode.loading));

    final collectionList = CollectionRepository.getList();

    int sortOrder;
    try {
      sortOrder = _prefs.getInt(_sortOrderKey) ?? SortOrderCode.name.index;
    } catch (_) {
      sortOrder = SortOrderCode.name.index;
    }
    final sortOrderCode = SortOrderCode.values[sortOrder];
    final isAscending = _prefs.getBool(_isAscendingKey) ?? true;

    _sortList(collectionList, sortOrderCode, isAscending);

    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      dataList: collectionList,
      isAscending: isAscending,
      sortOrder: sortOrderCode,
    ));
  }

  void deleteSelectedCollections() {
    for (var e in state.selectedSet) {
      CollectionRepository.delete(e);
    }
    refresh();
  }

  void setListOrder({SortOrderCode? sortOrder, bool? isAscending}) {
    final order = sortOrder ?? state.sortOrder;
    final ascending = isAscending ?? state.isAscending;
    final list = List<CollectionData>.from(state.dataList);

    _prefs.setInt(_sortOrderKey, order.index);
    _prefs.setBool(_isAscendingKey, ascending);

    _sortList(list, order, ascending);
    emit(state.copyWith(
      dataList: list,
      isAscending: ascending,
      sortOrder: order,
    ));
  }

  // Helper method to sort the collection list
  void _sortList(
    List<CollectionData> list,
    SortOrderCode sortOrder,
    bool isAscending,
  ) {
    list.sort((a, b) => isAscending
        ? compareNatural(a.name, b.name)
        : compareNatural(b.name, a.name));
  }
}
