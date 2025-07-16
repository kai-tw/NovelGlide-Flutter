part of '../shared_list.dart';

abstract class SharedListCubit<T> extends Cubit<SharedListState<T>> {
  SharedListCubit(super.initialState);

  Future<void> refresh();

  void unfocused() {
    isSelecting = false;
    isDragging = false;
  }

  set isSelecting(bool isSelecting) {
    emit(
        state.copyWith(isSelecting: isSelecting, selectedSet: const <Never>{}));
  }

  set isDragging(bool isDragging) {
    emit(state.copyWith(isDragging: isDragging));
  }

  void toggleSelectSingle(T data) {
    if (state.selectedSet.contains(data)) {
      deselectSingle(data);
    } else {
      selectSingle(data);
    }
  }

  void selectSingle(T data) {
    emit(state.copyWith(selectedSet: <T>{...state.selectedSet, data}));
  }

  void selectAll() {
    emit(state.copyWith(selectedSet: state.dataList.toSet()));
  }

  void deselectSingle(T data) {
    final Set<T> newSet = Set<T>.from(state.selectedSet);
    newSet.remove(data);
    emit(state.copyWith(selectedSet: newSet));
  }

  void deselectAll() {
    emit(state.copyWith(selectedSet: const <Never>{}));
  }

  void setListOrder({SortOrderCode? sortOrder, bool? isAscending}) {}
}
