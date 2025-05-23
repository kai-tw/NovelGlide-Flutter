part of '../shared_list.dart';

class SharedListState<T> extends Equatable {
  // Constructor initializes the state with default values.
  const SharedListState({
    this.code = LoadingStateCode.initial,
    this.sortOrder = SortOrderCode.name,
    this.dataList = const <Never>[],
    this.selectedSet = const <Never>{},
    this.isDragging = false,
    this.isSelecting = false,
    this.isAscending = false,
  });

  final LoadingStateCode code;
  final SortOrderCode sortOrder;
  final List<T> dataList;
  final Set<T> selectedSet;
  final bool isDragging;
  final bool isSelecting;
  final bool isAscending;

  bool get isSelectAll => selectedSet.length == dataList.length;
  bool get canRefresh =>
      !isDragging && !code.isLoading && !code.isBackgroundLoading;

  @override
  List<Object?> get props => <Object?>[
        code,
        sortOrder,
        dataList,
        selectedSet,
        isDragging,
        isSelecting,
        isAscending
      ];

  // Creates a copy of the current state with updated properties.
  SharedListState<T> copyWith({
    LoadingStateCode? code,
    SortOrderCode? sortOrder,
    List<T>? dataList,
    Set<T>? selectedSet,
    bool? isDragging,
    bool? isSelecting,
    bool? isAscending,
  }) {
    return SharedListState<T>(
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
