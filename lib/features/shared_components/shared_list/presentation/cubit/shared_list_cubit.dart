part of '../../shared_list.dart';

abstract class SharedListCubit<T> extends Cubit<SharedListState<T>> {
  SharedListCubit(super.initialState);

  StreamSubscription<void>? onRepositoryChangedSubscription;
  StreamSubscription<void>? onPreferenceChangedSubscription;

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

  set listType(SharedListType type) {
    emit(state.copyWith(listType: type));
    savePreference();
  }

  set sortOrder(SortOrderCode code) {
    emit(state.copyWith(
      dataList: sortList(state.dataList, code, state.isAscending),
      sortOrder: code,
    ));
    savePreference();
  }

  set isAscending(bool isAscending) {
    emit(state.copyWith(
      dataList: sortList(state.dataList, state.sortOrder, isAscending),
      isAscending: isAscending,
    ));
    savePreference();
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

  List<T> sortList(List<T> list, SortOrderCode sortOrder, bool isAscending) {
    final List<T> copyList = List<T>.from(list);
    copyList.sort(
      (T a, T b) => sortCompare(
        a,
        b,
        sortOrder: sortOrder,
        isAscending: isAscending,
      ),
    );
    return copyList;
  }

  int sortCompare(
    T a,
    T b, {
    required SortOrderCode sortOrder,
    required bool isAscending,
  });

  void savePreference();

  Future<void> refreshPreference();

  @override
  Future<void> close() async {
    onRepositoryChangedSubscription?.cancel();
    onPreferenceChangedSubscription?.cancel();
    return super.close();
  }
}
