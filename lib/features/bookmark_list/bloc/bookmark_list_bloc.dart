import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/bookmark_object.dart';

enum BookmarkListStateCode { normal, loading, empty }

class BookmarkListCubit extends Cubit<BookmarkListState> {
  BookmarkListCubit() : super(const BookmarkListState());

  void refresh() {
    final List<BookmarkObject> bookmarkList = BookmarkObject.getList();
    bookmarkList.sort(_sortBySavedTime);

    emit(BookmarkListState(
      code: bookmarkList.isEmpty ? BookmarkListStateCode.empty : BookmarkListStateCode.normal,
      bookmarkList: bookmarkList,
    ));
  }

  int _sortBySavedTime(BookmarkObject a, BookmarkObject b) {
    return b.savedTime.compareTo(a.savedTime);
  }
}

class BookmarkListState extends Equatable {
  final BookmarkListStateCode code;
  final List<BookmarkObject> bookmarkList;

  @override
  List<Object?> get props => [code, bookmarkList];

  const BookmarkListState({
    this.code = BookmarkListStateCode.loading,
    this.bookmarkList = const [],
  });

  BookmarkListState copyWith({
    BookmarkListStateCode? code,
    List<BookmarkObject>? bookmarkList,
  }) {
    return BookmarkListState(
      code: code ?? this.code,
      bookmarkList: bookmarkList ?? this.bookmarkList,
    );
  }
}
