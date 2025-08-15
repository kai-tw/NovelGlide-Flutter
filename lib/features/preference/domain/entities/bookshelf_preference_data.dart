import '../../../../enum/sort_order_code.dart';
import '../../../shared_components/shared_list/shared_list.dart';
import 'shared_list_preference_data.dart';

class BookshelfPreferenceData extends SharedListPreferenceData {
  const BookshelfPreferenceData({
    super.sortOrder = SortOrderCode.name,
    super.isAscending = false,
    super.listType = SharedListType.grid,
  });

  @override
  BookshelfPreferenceData copyWith({
    SortOrderCode? sortOrder,
    bool? isAscending,
    SharedListType? listType,
  }) {
    return BookshelfPreferenceData(
      sortOrder: sortOrder ?? this.sortOrder,
      isAscending: isAscending ?? this.isAscending,
      listType: listType ?? this.listType,
    );
  }
}
