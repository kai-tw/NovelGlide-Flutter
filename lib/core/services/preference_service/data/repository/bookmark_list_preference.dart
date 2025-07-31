part of '../../preference_service.dart';

class BookmarkListPreference extends SharedListPreference {
  BookmarkListPreference()
      : super(
          sortOrderKey: _key.sortOrder,
          isAscendingKey: _key.isAscending,
          listTypeKey: _key.listType,
          defaultSortOrder: SortOrderCode.name,
          defaultIsAscending: true,
          defaultListType: SharedListType.list,
        );

  static final SharedListPreferenceKey _key =
      SharedListPreferenceKey('bookmark');
}
