part of '../bookmark_service.dart';

class BookmarkPreference extends SharedListPreference {
  BookmarkPreference()
      : super(
          sortOrderKey: PreferenceKeys.bookmark.sortOrder,
          isAscendingKey: PreferenceKeys.bookmark.isAscending,
          listTypeKey: PreferenceKeys.bookmark.listType,
          defaultSortOrder: SortOrderCode.name,
          defaultIsAscending: true,
          defaultListType: SharedListType.list,
        );
}
