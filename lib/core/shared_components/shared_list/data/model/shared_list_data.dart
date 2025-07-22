part of '../../shared_list.dart';

class SharedListData extends Equatable {
  const SharedListData({
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
}
