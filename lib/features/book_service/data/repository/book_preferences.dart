part of '../../book_service.dart';

class BookPreference extends SharedListPreference {
  BookPreference()
      : super(
          sortOrderKey: PreferenceKeys.bookshelf.sortOrder,
          isAscendingKey: PreferenceKeys.bookshelf.isAscending,
          listTypeKey: PreferenceKeys.bookshelf.listType,
          defaultSortOrder: SortOrderCode.name,
          defaultIsAscending: true,
          defaultListType: SharedListType.grid,
        );
}
