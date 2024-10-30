import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/collection_data.dart';
import '../../../data/collection_repository.dart';
import '../../../enum/loading_state_code.dart';

class TocCollectionCubit extends Cubit<TocCollectionState> {
  final BookData bookData;

  factory TocCollectionCubit(BookData bookData) {
    final cubit = TocCollectionCubit._internal(
      bookData,
      const TocCollectionState(),
    );
    cubit._init();
    return cubit;
  }

  TocCollectionCubit._internal(this.bookData, super.initialState);

  void _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
  }

  void refresh() {
    List<CollectionData> collectionList = CollectionRepository.getList();
    Set<String> selectedCollections = collectionList
        .where((e) => e.pathList.contains(bookData.filePath))
        .map((e) => e.id)
        .toSet();

    collectionList.sort((a, b) => compareNatural(a.name, b.name));

    emit(TocCollectionState(
      code: LoadingStateCode.loaded,
      collectionList: collectionList,
      selectedCollections: selectedCollections,
    ));
  }

  void select(String id) {
    emit(state
        .copyWith(selectedCollections: {...state.selectedCollections, id}));
  }

  void deselect(String id) {
    emit(state.copyWith(
        selectedCollections: {...state.selectedCollections}..remove(id)));
  }

  void save() {
    for (CollectionData data in state.collectionList) {
      if (state.selectedCollections.contains(data.id)) {
        data.pathList.add(bookData.filePath);
      } else if (data.pathList.contains(bookData.filePath)) {
        data.pathList.remove(bookData.filePath);
      }
      CollectionRepository.save(data);
    }
  }
}

class TocCollectionState extends Equatable {
  final LoadingStateCode code;
  final List<CollectionData> collectionList;
  final Set<String> selectedCollections;

  @override
  List<Object?> get props => [code, collectionList, selectedCollections];

  const TocCollectionState({
    this.code = LoadingStateCode.initial,
    this.collectionList = const [],
    this.selectedCollections = const {},
  });

  TocCollectionState copyWith({
    LoadingStateCode? code,
    List<CollectionData>? collectionList,
    Set<String>? selectedCollections,
  }) {
    return TocCollectionState(
      code: code ?? this.code,
      collectionList: collectionList ?? this.collectionList,
      selectedCollections: selectedCollections ?? this.selectedCollections,
    );
  }
}
