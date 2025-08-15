import 'dart:async';

import 'package:collection/collection.dart';

import '../../../../../core/services/preference_service/preference_service.dart';
import '../../../../../enum/loading_state_code.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../../../features/shared_components/shared_list/shared_list.dart';
import '../../../../preference/domain/entities/shared_list_preference_data.dart';
import '../../../domain/entities/collection_data.dart';
import '../../../domain/use_cases/collection_delete_data_use_case.dart';
import '../../../domain/use_cases/collection_get_list_use_case.dart';
import '../../../domain/use_cases/collection_observe_change_use_case.dart';

typedef CollectionListState = SharedListState<CollectionData>;

class CollectionListCubit extends SharedListCubit<CollectionData> {
  factory CollectionListCubit(
    CollectionDeleteDataUseCase deleteCollectionDataUseCase,
    CollectionGetListUseCase getCollectionListUseCase,
    CollectionObserveChangeUseCase observeCollectionChangeUseCase,
  ) {
    final CollectionListCubit cubit = CollectionListCubit._(
      deleteCollectionDataUseCase,
      getCollectionListUseCase,
    );

    // Refresh at first.
    cubit.refresh();

    // Listen to collection changes.
    cubit.onRepositoryChangedSubscription =
        observeCollectionChangeUseCase().listen((_) => cubit.refresh());

    // Listen to collection list preference changes.
    cubit.onPreferenceChangedSubscription = PreferenceService
        .collectionList.onChangedController.stream
        .listen((_) => cubit.refreshPreference());

    return cubit;
  }

  CollectionListCubit._(
    this._deleteCollectionDataUseCase,
    this._getCollectionListUseCase,
  ) : super(const CollectionListState());

  final CollectionDeleteDataUseCase _deleteCollectionDataUseCase;
  final CollectionGetListUseCase _getCollectionListUseCase;

  @override
  Future<void> refresh() async {
    if (state.code.isLoading || state.code.isBackgroundLoading) {
      return;
    }

    // Load preferences.
    final SharedListPreferenceData preference =
        await PreferenceService.collectionList.load();

    // Load collection list.
    emit(CollectionListState(
      code: LoadingStateCode.loaded,
      dataList: sortList(
        await _getCollectionListUseCase(),
        preference.sortOrder,
        preference.isAscending,
      ),
      sortOrder: preference.sortOrder,
      isAscending: preference.isAscending,
      listType: preference.listType,
    ));
  }

  Future<void> dragToDelete(CollectionData data) async {
    await _deleteCollectionDataUseCase(<CollectionData>{data});
    await refresh();
  }

  Future<void> deleteSelectedCollections() async {
    await _deleteCollectionDataUseCase(state.selectedSet);
    await refresh();
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
    PreferenceService.collectionList.save(SharedListPreferenceData(
      sortOrder: state.sortOrder,
      isAscending: state.isAscending,
      listType: state.listType,
    ));
  }

  @override
  Future<void> refreshPreference() async {
    final SharedListPreferenceData preference =
        await PreferenceService.collectionList.load();
    emit(state.copyWith(
      sortOrder: preference.sortOrder,
      isAscending: preference.isAscending,
      listType: preference.listType,
    ));
  }
}
