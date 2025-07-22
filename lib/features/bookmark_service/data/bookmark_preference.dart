part of '../bookmark_service.dart';

class BookmarkPreference extends PreferenceRepository<void> {
  BookmarkPreference();

  final SharedListPreference list = SharedListPreference(
    sortOrderKey: PreferenceKeys.bookmark.sortOrder,
    isAscendingKey: PreferenceKeys.bookmark.isAscending,
    listTypeKey: PreferenceKeys.bookmark.listType,
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
