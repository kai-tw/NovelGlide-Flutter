import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/collection_data.dart';
import '../../../data/loading_state_code.dart';

class CollectionDialogCubit extends Cubit<CollectionDialogState> {
  final CollectionData collectionData;

  CollectionDialogCubit(this.collectionData) : super(const CollectionDialogState());

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
  }

  void refresh() async {
    List<BookData> bookList = [];

    for (String path in collectionData.pathList) {
      epub.EpubBook epubBook = await epub.EpubReader.readBook(File(path).readAsBytesSync());
      bookList.add(BookData(filePath: path, epubBook: epubBook));
    }

    emit(CollectionDialogState(
      code: LoadingStateCode.loaded,
      bookList: [...{...bookList}],
    ));
  }

  void reorder(int oldIndex, int newIndex) {
    collectionData.pathList.insert(newIndex, collectionData.pathList[oldIndex]);
    collectionData.pathList.removeAt(oldIndex);
    collectionData.save();
    refresh();
  }
}

class CollectionDialogState extends Equatable {
  final LoadingStateCode code;
  final List<BookData> bookList;

  @override
  List<Object?> get props => [code, bookList];

  const CollectionDialogState({
    this.code = LoadingStateCode.initial,
    this.bookList = const [],
  });

  CollectionDialogState copyWith({
    LoadingStateCode? code,
    List<BookData>? bookList,
  }) {
    return CollectionDialogState(
      code: code ?? this.code,
      bookList: bookList ?? this.bookList,
    );
  }
}
