import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../../toolbox/bookmark_utility.dart';

enum BookmarkListStateCode { normal, loading, empty }

class BookmarkListCubit extends Cubit<BookmarkListState> {
  BookmarkListCubit() : super(const BookmarkListState());

  void refresh() {
    final List<BookmarkData> bookmarkList = BookmarkUtility.getList();
    bookmarkList.sort(_sortBySavedTime);

    emit(BookmarkListState(
      code: bookmarkList.isEmpty ? BookmarkListStateCode.empty : BookmarkListStateCode.normal,
      bookmarkList: bookmarkList,
    ));
  }

  int _sortBySavedTime(BookmarkData a, BookmarkData b) {
    return b.savedTime.compareTo(a.savedTime);
  }
}

class BookmarkListState extends Equatable {
  final BookmarkListStateCode code;
  final List<BookmarkData> bookmarkList;

  @override
  List<Object?> get props => [code, bookmarkList];

  const BookmarkListState({
    this.code = BookmarkListStateCode.loading,
    this.bookmarkList = const [],
  });

  BookmarkListState copyWith({
    BookmarkListStateCode? code,
    List<BookmarkData>? bookmarkList,
  }) {
    return BookmarkListState(
      code: code ?? this.code,
      bookmarkList: bookmarkList ?? this.bookmarkList,
    );
  }
}
