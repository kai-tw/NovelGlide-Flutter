import '../../../../enum/sort_order_code.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import 'shared_list_preference_data.dart';

class CollectionListPreferenceData extends SharedListPreferenceData {
  const CollectionListPreferenceData({
    super.sortOrder = SortOrderCode.savedTime,
    super.isAscending = false,
    super.listType = SharedListType.list,
  });

  @override
  CollectionListPreferenceData copyWith({
    SortOrderCode? sortOrder,
    bool? isAscending,
    SharedListType? listType,
  }) {
    return CollectionListPreferenceData(
      sortOrder: sortOrder ?? this.sortOrder,
      isAscending: isAscending ?? this.isAscending,
      listType: listType ?? this.listType,
    );
  }
}
