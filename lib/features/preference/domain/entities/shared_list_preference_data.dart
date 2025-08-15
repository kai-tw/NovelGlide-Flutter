import 'package:equatable/equatable.dart';

import '../../../../enum/sort_order_code.dart';
import '../../../shared_components/shared_list/shared_list.dart';

class SharedListPreferenceData extends Equatable {
  const SharedListPreferenceData({
    required this.sortOrder,
    required this.isAscending,
    required this.listType,
  });

  final SortOrderCode sortOrder;
  final bool isAscending;
  final SharedListType listType;

  @override
  List<Object?> get props => <Object?>[
        sortOrder,
        isAscending,
        listType,
      ];

  SharedListPreferenceData copyWith({
    SortOrderCode? sortOrder,
    bool? isAscending,
    SharedListType? listType,
  }) {
    return SharedListPreferenceData(
      sortOrder: sortOrder ?? this.sortOrder,
      isAscending: isAscending ?? this.isAscending,
      listType: listType ?? this.listType,
    );
  }
}
