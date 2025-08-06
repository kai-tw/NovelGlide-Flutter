import 'dart:async';

import 'package:collection/collection.dart';

import '../../../../../core/services/preference_service/preference_service.dart';
import '../../../../../enum/loading_state_code.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../../../features/shared_components/shared_list/shared_list.dart';
import '../../../collection_service.dart';

typedef CollectionListState = SharedListState<CollectionData>;

class CollectionListCubit extends SharedListCubit<CollectionData> {
  factory CollectionListCubit() {
    final CollectionListCubit cubit = CollectionListCubit._();

    // Refresh at first.
    cubit.refresh();

    // Listen to collection changes.
    cubit.onRepositoryChangedSubscription = CollectionService
        .repository.onChangedController.stream
        .listen((_) => cubit.refresh());

    // Listen to collection list preference changes.
    cubit.onPreferenceChangedSubscription = PreferenceService
        .collectionList.onChangedController.stream
        .listen((_) => cubit.refreshPreference());

    return cubit;
  }

  CollectionListCubit._() : super(const CollectionListState());

  @override
  Future<void> refresh() async {
    if (state.code.isLoading || state.code.isBackgroundLoading) {
      return;
    }

    // Load preferences.
    final SharedListData preference =
        await PreferenceService.collectionList.load();

    // Load collection list.
    emit(CollectionListState(
      code: LoadingStateCode.loaded,
      dataList: sortList(
        await CollectionService.repository.getList(),
        preference.sortOrder,
        preference.isAscending,
      ),
      sortOrder: preference.sortOrder,
      isAscending: preference.isAscending,
      listType: preference.listType,
    ));
  }

  void deleteSelectedCollections() {
    state.selectedSet.forEach(CollectionService.repository.deleteByData);
    refresh();
  }

  @override
  int sortCompare(
    CollectionData a,
    CollectionData b, {
    required SortOrderCode sortOrder,
    required bool isAscending,
  }) {
    return isAscending
        ? compareNatural(a.name, b.name)
        : compareNatural(b.name, a.name);
  }

  @override
  void savePreference() {
    PreferenceService.collectionList.save(SharedListData(
      sortOrder: state.sortOrder,
      isAscending: state.isAscending,
      listType: state.listType,
    ));
  }

  @override
  Future<void> refreshPreference() async {
    final SharedListData preference =
        await PreferenceService.collectionList.load();
    emit(state.copyWith(
      sortOrder: preference.sortOrder,
      isAscending: preference.isAscending,
      listType: preference.listType,
    ));
  }
}
