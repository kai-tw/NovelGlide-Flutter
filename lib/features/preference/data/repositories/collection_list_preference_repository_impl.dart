import '../../../../enum/sort_order_code.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import '../../domain/entities/collection_list_preference_data.dart';
import '../../domain/entities/preference_keys.dart';
import 'shared_list_preference_repository_impl.dart';

class CollectionListPreferenceRepositoryImpl
    extends SharedListPreferenceRepositoryImpl<CollectionListPreferenceData> {
  CollectionListPreferenceRepositoryImpl(super._localDataSource);

  @override
  CollectionListPreferenceData createData({
    SortOrderCode? sortOrder,
    bool? isAscending,
    SharedListType? listType,
  }) {
    return const CollectionListPreferenceData().copyWith(
      sortOrder: sortOrder,
      isAscending: isAscending,
      listType: listType,
    );
  }

  @override
  PreferenceKeys get isAscendingKey => PreferenceKeys.collectionListIsAscending;

  @override
  PreferenceKeys get listTypeKey => PreferenceKeys.collectionListListType;

  @override
  PreferenceKeys get sortOrderKey => PreferenceKeys.collectionListSortOrder;
}
