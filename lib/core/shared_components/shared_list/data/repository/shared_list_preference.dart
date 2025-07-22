part of '../../shared_list.dart';

class SharedListPreference extends PreferenceRepository<SharedListData> {
  SharedListPreference({
    required this.sortOrderKey,
    required this.isAscendingKey,
    required this.listTypeKey,
    required this.defaultSortOrder,
    required this.defaultIsAscending,
    required this.defaultListType,
  });

  /// ==== Preference keys ====
  final String sortOrderKey;
  final String isAscendingKey;
  final String listTypeKey;

  /// ==== Preference Default Values ====
  final SortOrderCode defaultSortOrder;
  final bool defaultIsAscending;
  final SharedListType defaultListType;

  /// Lazy load preferences.
  @override
  Future<SharedListData> load() async {
    return SharedListData(
      sortOrder: SortOrderCode
          .values[await tryGetInt(sortOrderKey) ?? defaultSortOrder.index],
      isAscending: await tryGetBool(isAscendingKey) ?? defaultIsAscending,
      listType: SharedListType
          .values[await tryGetInt(listTypeKey) ?? defaultListType.index],
    );
  }

  /// Reset preferences.
  @override
  Future<void> reset() async {
    remove(sortOrderKey);
    remove(isAscendingKey);
    remove(listTypeKey);
  }

  @override
  Future<void> save(SharedListData data) async {
    await Future.wait(<Future<void>>[
      setInt(sortOrderKey, data.sortOrder.index),
      setBool(isAscendingKey, data.isAscending),
      setInt(listTypeKey, data.listType.index),
    ]);
  }
}
