part of '../../book_service.dart';

class BookPreference extends PreferenceRepository<void> {
  final SharedListPreference bookshelf = SharedListPreference(
    sortOrderKey: PreferenceKeys.bookshelf.sortOrder,
    isAscendingKey: PreferenceKeys.bookshelf.isAscending,
    listTypeKey: PreferenceKeys.bookshelf.listType,
    defaultSortOrder: SortOrderCode.name,
    defaultIsAscending: true,
    defaultListType: SharedListType.grid,
  );

  @override
  Future<void> load() async {}

  @override
  Future<void> reset() async {}

  @override
  Future<void> save(_) async {}
}
