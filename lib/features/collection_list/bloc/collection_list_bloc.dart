import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/collection_data.dart';
import '../../../data/preference_keys.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/sort_order_code.dart';

class CollectionListCubit extends Cubit<CollectionListState> {
  CollectionListCubit() : super(const CollectionListState());

  void refresh() async {
    List<CollectionData> collectionList = await CollectionData.getList();
    _sortList(collectionList, state.sortOrder, state.isAscending);
    emit(CollectionListState(
      code: LoadingStateCode.loaded,
      collectionList: collectionList,
    ));
  }

  void reorder(int oldIndex, int newIndex) {
    final List<CollectionData> collectionList = state.collectionList;
    final CollectionData item = collectionList.removeAt(oldIndex);
    collectionList.insert(newIndex - (oldIndex < newIndex ? 1 : 0), item);
    emit(CollectionListState(
      code: LoadingStateCode.loaded,
      collectionList: collectionList,
    ));
    CollectionData.reorder(oldIndex, newIndex);
  }

  void setSelecting(bool isSelecting) {
    emit(state.copyWith(
      isSelecting: isSelecting,
      selectedCollections: {},
    ));
  }

  void selectAll() {
    emit(state.copyWith(selectedCollections: state.collectionList.toSet()));
  }

  void selectCollection(CollectionData data) {
    emit(state.copyWith(selectedCollections: {...state.selectedCollections, data}));
  }

  void deselectAll() {
    emit(state.copyWith(selectedCollections: const {}));
  }

  void deselectCollection(CollectionData data) {
    Set<CollectionData> newSet = Set<CollectionData>.from(state.selectedCollections);
    newSet.remove(data);

    emit(state.copyWith(selectedCollections: newSet));
  }

  Future<void> deleteSelectedCollections() async {
    await Future.wait(state.selectedCollections.map((e) => e.delete()));
    refresh();
  }

  Future<void> setListOrder({SortOrderCode? sortOrder, bool? isAscending}) async {
    final SortOrderCode order = sortOrder ?? state.sortOrder;
    final bool ascending = isAscending ?? state.isAscending;
    List<CollectionData> list = List.from(state.collectionList);

    // Save the sorting preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceKeys.collection.sortOrder, order.toString());
    prefs.setBool(PreferenceKeys.collection.isAscending, ascending);

    _sortList(list, order, ascending);
    emit(state.copyWith(
      collectionList: list,
      isAscending: ascending,
      sortOrder: order,
    ));
  }

  void _sortList(List<CollectionData> list, SortOrderCode sortOrder, bool isAscending) {
    list.sort((a, b) => isAscending ? compareNatural(a.name, b.name) : compareNatural(b.name, a.name));
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
  List<Object?> get props => [code, collectionList, isSelecting, selectedCollections];

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
