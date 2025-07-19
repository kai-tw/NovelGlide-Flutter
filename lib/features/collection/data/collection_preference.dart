part of '../collection_service.dart';

class CollectionPreference extends SharedListPreference {
  CollectionPreference()
      : super(
          sortOrderKey: PreferenceKeys.collection.sortOrder,
          isAscendingKey: PreferenceKeys.collection.isAscending,
          listTypeKey: PreferenceKeys.collection.listType,
          defaultSortOrder: SortOrderCode.name,
          defaultIsAscending: true,
          defaultListType: SharedListType.list,
        );
}
