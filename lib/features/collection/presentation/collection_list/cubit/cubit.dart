import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../../core/shared_components/shared_list/shared_list.dart';
import '../../../../../enum/loading_state_code.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../collection_service.dart';

typedef CollectionListState = SharedListState<CollectionData>;

class CollectionListCubit extends SharedListCubit<CollectionData> {
  factory CollectionListCubit() {
    final CollectionListCubit cubit = CollectionListCubit._();
    WidgetsBinding.instance.addPostFrameCallback((_) => cubit.refresh());
    return cubit;
  }

  CollectionListCubit._() : super(const CollectionListState());

  @override
  Future<void> refresh() async {
    if (state.code.isLoading || state.code.isBackgroundLoading) {
      return;
    }

    // Load preferences.
    await CollectionService.preference.load();

    emit(CollectionListState(
      code: LoadingStateCode.loading,
      dataList: List<CollectionData>.from(state.dataList),
      sortOrder: CollectionService.preference.sortOrder,
      isAscending: CollectionService.preference.isAscending,
      listType: CollectionService.preference.listType,
    ));

    // Load collection list.
    final List<CollectionData> collectionList =
        CollectionService.repository.getList();
    _sortList(collectionList, CollectionService.preference.sortOrder,
        CollectionService.preference.isAscending);

    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      dataList: collectionList,
    ));
  }

  void deleteSelectedCollections() {
    state.selectedSet.forEach(CollectionService.repository.delete);
    refresh();
  }

  @override
  void setListOrder({SortOrderCode? sortOrder, bool? isAscending}) {
    final SortOrderCode order = sortOrder ?? state.sortOrder;
    final bool ascending = isAscending ?? state.isAscending;
    final List<CollectionData> list = List<CollectionData>.from(state.dataList);

    CollectionService.preference.sortOrder = order;
    CollectionService.preference.isAscending = ascending;

    _sortList(list, order, ascending);
    emit(state.copyWith(
      dataList: list,
      isAscending: ascending,
      sortOrder: order,
    ));
  }

  @override
  set listType(SharedListType value) {
    CollectionService.preference.listType = value;
    super.listType = value;
  }

  // Helper method to sort the collection list
  void _sortList(
    List<CollectionData> list,
    SortOrderCode sortOrder,
    bool isAscending,
  ) {
    list.sort((CollectionData a, CollectionData b) => isAscending
        ? compareNatural(a.name, b.name)
        : compareNatural(b.name, a.name));
  }
}
