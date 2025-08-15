import 'dart:async';

import '../../../../enum/sort_order_code.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import '../../domain/entities/preference_keys.dart';
import '../../domain/entities/shared_list_preference_data.dart';
import '../../domain/repositories/preference_repository.dart';
import '../data_sources/preference_local_data_source.dart';

abstract class SharedListPreferenceRepositoryImpl<
        T extends SharedListPreferenceData>
    implements SharedListPreferenceRepository<T> {
  SharedListPreferenceRepositoryImpl(this._localDataSource);

  final PreferenceLocalDataSource _localDataSource;
  final StreamController<T> _onChangeController =
      StreamController<T>.broadcast();

  PreferenceKeys get sortOrderKey;

  PreferenceKeys get isAscendingKey;

  PreferenceKeys get listTypeKey;

  T createData({
    SortOrderCode? sortOrder,
    bool? isAscending,
    SharedListType? listType,
  });

  @override
  Future<T> getPreference() async {
    final T defaultData = createData();

    // Get the sort order
    final int sortOrderIndex = await _localDataSource.tryGetInt(sortOrderKey) ??
        defaultData.sortOrder.index;

    // Get if is sorting ascending
    final bool isAscending =
        await _localDataSource.tryGetBool(isAscendingKey) ??
            defaultData.isAscending;

    // Get the list display type
    final int listTypeIndex = await _localDataSource.tryGetInt(listTypeKey) ??
        defaultData.listType.index;

    // Return the data
    return createData(
      sortOrder: SortOrderCode.values[sortOrderIndex],
      isAscending: isAscending,
      listType: SharedListType.values[listTypeIndex],
    );
  }

  @override
  Stream<T> get onChangeStream => _onChangeController.stream;

  @override
  Future<void> resetPreference() async {
    await _localDataSource.remove(sortOrderKey);
    await _localDataSource.remove(isAscendingKey);
    await _localDataSource.remove(listTypeKey);

    _onChangeController.add(createData());
  }

  @override
  Future<void> savePreference(T data) async {
    await _localDataSource.setInt(sortOrderKey, data.sortOrder.index);
    await _localDataSource.setBool(isAscendingKey, data.isAscending);
    await _localDataSource.setInt(listTypeKey, data.listType.index);

    _onChangeController.add(data);
  }
}
