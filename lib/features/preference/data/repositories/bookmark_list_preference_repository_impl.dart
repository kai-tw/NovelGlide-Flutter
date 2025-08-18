import '../../../../enum/sort_order_code.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import '../../domain/entities/bookmark_list_preference_data.dart';
import '../../domain/entities/preference_keys.dart';
import 'shared_list_preference_repository_impl.dart';

class BookmarkListPreferenceRepositoryImpl
    extends SharedListPreferenceRepositoryImpl<BookmarkListPreferenceData> {
  BookmarkListPreferenceRepositoryImpl(super._localDataSource);

  @override
  BookmarkListPreferenceData createData({
    SortOrderCode? sortOrder,
    bool? isAscending,
    SharedListType? listType,
  }) {
    return const BookmarkListPreferenceData().copyWith(
      sortOrder: sortOrder,
      isAscending: isAscending,
      listType: listType,
    );
  }

  @override
  PreferenceKeys get isAscendingKey => PreferenceKeys.bookmarkListIsAscending;

  @override
  PreferenceKeys get listTypeKey => PreferenceKeys.bookmarkListListType;

  @override
  PreferenceKeys get sortOrderKey => PreferenceKeys.bookmarkListSortOrder;
}
