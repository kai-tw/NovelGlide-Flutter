part of '../common_list.dart';

class CommonListState<T> extends Equatable {
  final LoadingStateCode code;
  final SortOrderCode sortOrder;
  final List<T> dataList;
  final Set<T> selectedSet;
  final bool isDragging;
  final bool isSelecting;
  final bool isAscending;

  bool get isSelectAll => selectedSet.length == dataList.length;

  @override
  List<Object?> get props => [
        code,
        sortOrder,
        dataList,
        selectedSet,
        isDragging,
        isSelecting,
        isAscending
      ];

  // Constructor initializes the state with default values.
  const CommonListState({
    this.code = LoadingStateCode.initial,
    this.sortOrder = SortOrderCode.name,
    this.dataList = const [],
    this.selectedSet = const {},
    this.isDragging = false,
    this.isSelecting = false,
    this.isAscending = false,
  });

  // Creates a copy of the current state with updated properties.
  CommonListState<T> copyWith({
    LoadingStateCode? code,
    SortOrderCode? sortOrder,
    List<T>? dataList,
    Set<T>? selectedSet,
    bool? isDragging,
    bool? isSelecting,
    bool? isAscending,
  }) {
    return CommonListState<T>(
      code: code ?? this.code,
      sortOrder: sortOrder ?? this.sortOrder,
      dataList: dataList ?? this.dataList,
      selectedSet: selectedSet ?? this.selectedSet,
      isDragging: isDragging ?? this.isDragging,
      isSelecting: isSelecting ?? this.isSelecting,
      isAscending: isAscending ?? this.isAscending,
    );
  }
}
