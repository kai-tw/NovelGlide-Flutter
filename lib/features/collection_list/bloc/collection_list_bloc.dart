import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/collection_data.dart';
import '../../../data/loading_state_code.dart';

class CollectionListCubit extends Cubit<CollectionListState> {
  CollectionListCubit() : super(const CollectionListState());

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      emit(const CollectionListState(code: LoadingStateCode.loading));
      refresh();
    });
  }

  void refresh() {
    emit(CollectionListState(
      code: LoadingStateCode.loaded,
      collectionList: CollectionData.getList(),
    ));
  }
}

class CollectionListState extends Equatable {
  final LoadingStateCode code;
  final List<CollectionData> collectionList;

  @override
  List<Object?> get props => [code, collectionList];

  const CollectionListState({
    this.code = LoadingStateCode.initial,
    this.collectionList = const <CollectionData>[],
  });
}
