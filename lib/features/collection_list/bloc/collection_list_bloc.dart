import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/collection_data.dart';
import '../../../data/collection_repository.dart';
import '../../../data/preference_keys.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/sort_order_code.dart';

class CollectionListCubit extends Cubit<CollectionListState> {
  // Keys for storing sort order and ascending preference in shared preferences
  final _sortOrderKey = PreferenceKeys.collection.sortOrder;
  final _isAscendingKey = PreferenceKeys.collection.isAscending;

  // Constructor initializing the cubit with an initial state
  CollectionListCubit() : super(const CollectionListState());

  // Refreshes the collection list by fetching data and applying saved sort preferences
  Future<void> refresh() async {
    final collectionList = CollectionRepository.getList();
    final prefs = await SharedPreferences.getInstance();

    final sortOrder = SortOrderCode.fromString(
      prefs.getString(_sortOrderKey),
      defaultValue: SortOrderCode.name,
    );
    final isAscending = prefs.getBool(_isAscendingKey) ?? true;

    _sortList(collectionList, sortOrder, isAscending);

    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      collectionList: collectionList,
      isAscending: isAscending,
      sortOrder: sortOrder,
    ));
  }

  // Reorders the collection list and updates the state
  void reorder(int oldIndex, int newIndex) {
    final collectionList = List<CollectionData>.from(state.collectionList);
    final item = collectionList.removeAt(oldIndex);
    collectionList.insert(newIndex - (oldIndex < newIndex ? 1 : 0), item);

    emit(state.copyWith(collectionList: collectionList));
    CollectionRepository.reorder(oldIndex, newIndex);
  }

  // Sets the selecting mode and clears selected collections
  void setSelecting(bool isSelecting) {
    emit(state.copyWith(
      isSelecting: isSelecting,
      selectedCollections: {},
    ));
  }

  // Selects all collections in the list
  void selectAll() {
    emit(state.copyWith(selectedCollections: state.collectionList.toSet()));
  }

  // Selects a specific collection
  void selectCollection(CollectionData data) {
    emit(state.copyWith(
      selectedCollections: {...state.selectedCollections, data},
    ));
  }

  // Deselects all collections
  void deselectAll() {
    emit(state.copyWith(selectedCollections: const {}));
  }

  // Deselects a specific collection
  void deselectCollection(CollectionData data) {
    final newSet = Set<CollectionData>.from(state.selectedCollections)
      ..remove(data);
    emit(state.copyWith(selectedCollections: newSet));
  }

  // Deletes all selected collections and refreshes the list
  void deleteSelectedCollections() {
    for (var e in state.selectedCollections) {
      CollectionRepository.delete(e);
    }
    refresh();
  }

  // Sets the list order and saves preferences
  Future<void> setListOrder({
    SortOrderCode? sortOrder,
    bool? isAscending,
  }) async {
    final order = sortOrder ?? state.sortOrder;
    final ascending = isAscending ?? state.isAscending;
    final list = List<CollectionData>.from(state.collectionList);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_sortOrderKey, order.toString());
    prefs.setBool(_isAscendingKey, ascending);

    _sortList(list, order, ascending);
    emit(state.copyWith(
      collectionList: list,
      isAscending: ascending,
      sortOrder: order,
    ));
  }

  // Helper method to sort the collection list
  void _sortList(
    List<CollectionData> list,
    SortOrderCode sortOrder,
    bool isAscending,
  ) {
    list.sort((a, b) => isAscending
        ? compareNatural(a.name, b.name)
        : compareNatural(b.name, a.name));
  }
}

class CollectionListState extends Equatable {
  final LoadingStateCode code;
  final List<CollectionData> collectionList;
  final bool isSelecting;
  final Set<CollectionData> selectedCollections;
  final bool isAscending;
  final SortOrderCode sortOrder;

  @override
  List<Object?> get props => [
        code,
        collectionList,
        isSelecting,
        selectedCollections,
        isAscending,
        sortOrder,
      ];

  const CollectionListState({
    this.code = LoadingStateCode.initial,
    this.collectionList = const <CollectionData>[],
    this.isSelecting = false,
    this.selectedCollections = const <CollectionData>{},
    this.isAscending = true,
    this.sortOrder = SortOrderCode.name,
  });

  CollectionListState copyWith({
    LoadingStateCode? code,
    List<CollectionData>? collectionList,
    bool? isSelecting,
    Set<CollectionData>? selectedCollections,
    bool? isAscending,
    SortOrderCode? sortOrder,
  }) {
    return CollectionListState(
      code: code ?? this.code,
      collectionList: collectionList ?? this.collectionList,
      isSelecting: isSelecting ?? this.isSelecting,
      selectedCollections: selectedCollections ?? this.selectedCollections,
      isAscending: isAscending ?? this.isAscending,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
