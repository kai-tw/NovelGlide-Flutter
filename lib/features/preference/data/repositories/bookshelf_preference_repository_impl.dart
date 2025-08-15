import '../../../../enum/sort_order_code.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import '../../domain/entities/bookshelf_preference_data.dart';
import '../../domain/entities/preference_keys.dart';
import 'shared_list_preference_repository_impl.dart';

class BookshelfPreferenceRepositoryImpl
    extends SharedListPreferenceRepositoryImpl<BookshelfPreferenceData> {
  BookshelfPreferenceRepositoryImpl(super._localDataSource);

  @override
  BookshelfPreferenceData createData({
    SortOrderCode? sortOrder,
    bool? isAscending,
    SharedListType? listType,
  }) {
    return const BookshelfPreferenceData().copyWith(
      sortOrder: sortOrder,
      isAscending: isAscending,
      listType: listType,
    );
  }

  @override
  PreferenceKeys get isAscendingKey => PreferenceKeys.bookshelfIsAscending;

  @override
  PreferenceKeys get listTypeKey => PreferenceKeys.bookshelfListType;

  @override
  PreferenceKeys get sortOrderKey => PreferenceKeys.bookshelfSortOrder;
}
