import 'dart:async';

import 'package:collection/collection.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../../../features/shared_components/shared_list/shared_list.dart';
import '../../../../preference/domain/entities/collection_list_preference_data.dart';
import '../../../../preference/domain/use_cases/preference_get_use_cases.dart';
import '../../../../preference/domain/use_cases/preference_observe_change_use_case.dart';
import '../../../../preference/domain/use_cases/preference_save_use_case.dart';
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
    CollectionListGetPreferenceUseCase getPreferenceUseCase,
    CollectionListSavePreferenceUseCase savePreferenceUseCase,
    CollectionListObserveChangeUseCase observePreferenceUseCase,
  ) {
    final CollectionListCubit cubit = CollectionListCubit._(
      deleteCollectionDataUseCase,
      getCollectionListUseCase,
      getPreferenceUseCase,
      savePreferenceUseCase,
    );

    // Refresh at first.
    cubit.refresh();

    // Listen to collection changes.
    cubit.onRepositoryChangedSubscription =
        observeCollectionChangeUseCase().listen((_) => cubit.refresh());

    // Listen to collection list preference changes.
    cubit.onPreferenceChangedSubscription =
        observePreferenceUseCase().listen((_) => cubit.refreshPreference());

    return cubit;
  }

  CollectionListCubit._(
    this._deleteCollectionDataUseCase,
    this._getCollectionListUseCase,
    this._getPreferenceUseCase,
    this._savePreferenceUseCase,
  ) : super(const CollectionListState());

  // Collection use cases
  final CollectionDeleteDataUseCase _deleteCollectionDataUseCase;
  final CollectionGetListUseCase _getCollectionListUseCase;

  // Preferences use cases
  final CollectionListGetPreferenceUseCase _getPreferenceUseCase;
  final CollectionListSavePreferenceUseCase _savePreferenceUseCase;

  @override
  Future<void> refresh() async {
    if (state.code.isLoading || state.code.isBackgroundLoading) {
      return;
    }

    // Load preferences.
    final CollectionListPreferenceData preference =
        await _getPreferenceUseCase();

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
    _savePreferenceUseCase(CollectionListPreferenceData(
      sortOrder: state.sortOrder,
      isAscending: state.isAscending,
      listType: state.listType,
    ));
  }

  @override
  Future<void> refreshPreference() async {
    final CollectionListPreferenceData preference =
        await _getPreferenceUseCase();
    emit(state.copyWith(
      sortOrder: preference.sortOrder,
      isAscending: preference.isAscending,
      listType: preference.listType,
    ));
  }
}
