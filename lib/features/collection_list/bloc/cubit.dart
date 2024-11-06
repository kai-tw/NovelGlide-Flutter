part of '../collection_list.dart';

typedef _State = CommonListState<CollectionData>;

class CollectionListCubit extends CommonListCubit<CollectionData> {
  // Keys for storing sort order and ascending preference in shared preferences
  final _sortOrderKey = PreferenceKeys.collection.sortOrder;
  final _isAscendingKey = PreferenceKeys.collection.isAscending;

  // Constructor initializing the cubit with an initial state
  factory CollectionListCubit() {
    final cubit = CollectionListCubit._internal(const _State());
    cubit.refresh();
    return cubit;
  }

  CollectionListCubit._internal(super.initialState);

  // Refreshes the collection list by fetching data and applying saved sort preferences
  @override
  Future<void> refresh() async {
    final collectionList = CollectionRepository.getList();
    final prefs = await SharedPreferences.getInstance();

    final sortOrder = SortOrderCode.fromString(
      prefs.getString(_sortOrderKey),
      defaultValue: SortOrderCode.name,
    );
    final isAscending = prefs.getBool(_isAscendingKey) ?? true;

    _sortList(collectionList, sortOrder, isAscending);

    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      dataList: collectionList,
      isAscending: isAscending,
      sortOrder: sortOrder,
    ));
  }

  // Deletes all selected collections and refreshes the list
  void deleteSelectedCollections() {
    for (var e in state.selectedSet) {
      CollectionRepository.delete(e);
    }
    refresh();
  }

  // Sets the list order and saves preferences
  Future<void> setListOrder({
    SortOrderCode? sortOrder,
    bool? isAscending,
  }) async {
    final order = sortOrder ?? state.sortOrder;
    final ascending = isAscending ?? state.isAscending;
    final list = List<CollectionData>.from(state.dataList);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_sortOrderKey, order.toString());
    prefs.setBool(_isAscendingKey, ascending);

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
