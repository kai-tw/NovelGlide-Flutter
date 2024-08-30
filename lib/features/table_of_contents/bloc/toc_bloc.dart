import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../data/chapter_data.dart';

class TocCubit extends Cubit<TocState> {
  final PageStorageBucket bucket = PageStorageBucket();
  final ScrollController scrollController = ScrollController();
  BookData bookData;

  TocCubit(this.bookData) : super(TocState(bookName: bookData.name, filePath: bookData.filePath));

  Future<void> refresh({BookData? newData}) async {
    bookData = newData ?? bookData;
    final List<ChapterData> chapterList = bookData.chapterList ?? [];

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      emit(TocState(
        bookName: bookData.name,
        filePath: bookData.filePath,
        coverBytes: bookData.coverBytes,
        code: chapterList.isEmpty ? TocStateCode.empty : TocStateCode.normal,
        chapterList: chapterList,
        bookmarkData: BookmarkData.get(bookData.filePath),
      ));
    });
  }
}

class TocState extends Equatable {
  final String bookName;
  final String filePath;
  final Uint8List? coverBytes;
  final TocStateCode code;
  final List<ChapterData> chapterList;
  final BookmarkData? bookmarkData;

  @override
  List<Object?> get props => [bookName, code, chapterList, bookmarkData];

  const TocState({
    required this.bookName,
    required this.filePath,
    this.coverBytes,
    this.code = TocStateCode.loading,
    this.chapterList = const [],
    this.bookmarkData,
  });

  TocState copyWith({
    String? bookName,
    String? filePath,
    Uint8List? coverBytes,
    TocStateCode? code,
    List<ChapterData>? chapterList,
    BookmarkData? bookmarkData,
  }) {
    return TocState(
      bookName: bookName ?? this.bookName,
      filePath: filePath ?? this.filePath,
      coverBytes: coverBytes ?? this.coverBytes,
      code: code ?? this.code,
      chapterList: chapterList ?? this.chapterList,
      bookmarkData: bookmarkData ?? this.bookmarkData,
    );
  }
}

enum TocStateCode { loading, normal, empty }
