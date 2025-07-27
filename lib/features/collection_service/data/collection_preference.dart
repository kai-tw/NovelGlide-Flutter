part of '../collection_service.dart';

class CollectionPreference extends PreferenceRepository<void> {
  CollectionPreference();

  final SharedListPreference list = SharedListPreference(
    sortOrderKey: PreferenceKeys.collection.sortOrder,
    isAscendingKey: PreferenceKeys.collection.isAscending,
    listTypeKey: PreferenceKeys.collection.listType,
    defaultSortOrder: SortOrderCode.name,
    defaultIsAscending: true,
    defaultListType: SharedListType.list,
  );

  @override
  Future<void> load() async {}

  @override
  Future<void> reset() async {}

  @override
  Future<void> save(_) async {}
}
