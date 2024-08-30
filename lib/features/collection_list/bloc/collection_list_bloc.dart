import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/collection_data.dart';

class CollectionListCubit extends Cubit<CollectionListState> {
  CollectionListCubit() : super(const CollectionListState());

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  void refresh() {
    emit(CollectionListState(collectionList: CollectionData.getList()));
  }
}

class CollectionListState extends Equatable {
  final List<CollectionData> collectionList;

  @override
  List<Object?> get props => [collectionList];

  const CollectionListState({
    this.collectionList = const <CollectionData>[],
  });
}
