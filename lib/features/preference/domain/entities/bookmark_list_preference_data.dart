import '../../../../enum/sort_order_code.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import 'shared_list_preference_data.dart';

class BookmarkListPreferenceData extends SharedListPreferenceData {
  const BookmarkListPreferenceData({
    super.sortOrder = SortOrderCode.savedTime,
    super.isAscending = false,
    super.listType = SharedListType.list,
  });

  @override
  BookmarkListPreferenceData copyWith({
    SortOrderCode? sortOrder,
    bool? isAscending,
    SharedListType? listType,
  }) {
    return BookmarkListPreferenceData(
      sortOrder: sortOrder ?? this.sortOrder,
      isAscending: isAscending ?? this.isAscending,
      listType: listType ?? this.listType,
    );
  }
}
