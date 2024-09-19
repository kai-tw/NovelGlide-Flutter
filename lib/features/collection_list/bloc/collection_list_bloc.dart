import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/collection_data.dart';
import '../../../data/loading_state_code.dart';
import '../../../data/sort_order_code.dart';

class CollectionListCubit extends Cubit<CollectionListState> {
  CollectionListCubit() : super(const CollectionListState());

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      emit(const CollectionListState(code: LoadingStateCode.loading));
      refresh();
    });
  }

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

  void deleteSelectedCollections() {
    for (CollectionData data in state.selectedCollections) {
      data.delete();
    }
    refresh();
  }

  void setListOrder({SortOrderCode? sortOrder, bool? isAscending}) {
    final SortOrderCode order = sortOrder ?? state.sortOrder;
    final bool ascending = isAscending ?? state.isAscending;
    List<CollectionData> list = List.from(state.collectionList);

    final Box box = Hive.box(name: 'settings');
    box.put('collection.sortOrder', order.toString());
    box.put('collection.isAscending', ascending);
    box.close();

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
