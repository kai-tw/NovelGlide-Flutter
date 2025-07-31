part of '../../preference_service.dart';

class BookshelfPreference extends SharedListPreference {
  BookshelfPreference()
      : super(
          sortOrderKey: _key.sortOrder,
          isAscendingKey: _key.isAscending,
          listTypeKey: _key.listType,
          defaultSortOrder: SortOrderCode.name,
          defaultIsAscending: true,
          defaultListType: SharedListType.grid,
        );

  static final SharedListPreferenceKey _key =
      SharedListPreferenceKey('bookshelf');
}
