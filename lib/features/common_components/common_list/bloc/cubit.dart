part of '../list_template.dart';

abstract class CommonListCubit<T> extends Cubit<CommonListState<T>> {
  CommonListCubit(super.initialState);

  Future<void> refresh();

  void unfocused() {
    setSelecting(false);
    setDragging(false);
  }

  void setSelecting(bool isSelecting) {
    emit(state.copyWith(isSelecting: isSelecting, selectedSet: const {}));
  }

  void setDragging(bool isDragging) {
    emit(state.copyWith(isDragging: isDragging));
  }

  void selectSingle(T data) {
    emit(state.copyWith(selectedSet: {...state.selectedSet, data}));
  }

  void selectAll() {
    emit(state.copyWith(selectedSet: state.dataList.toSet()));
  }

  void deselectSingle(T data) {
    Set<T> newSet = Set<T>.from(state.selectedSet);
    newSet.remove(data);
    emit(state.copyWith(selectedSet: newSet));
  }

  void deselectAll() {
    emit(state.copyWith(selectedSet: const {}));
  }
}
