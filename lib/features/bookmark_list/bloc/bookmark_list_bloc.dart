import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/bookmark_object.dart';
import '../../../shared/file_process.dart';

enum BookmarkListStateCode { normal, unload, loading, empty }

class BookmarkListCubit extends Cubit<BookmarkListState> {
  BookmarkListCubit() : super(const BookmarkListState());

  void refresh() async {
    emit(const BookmarkListState(code: BookmarkListStateCode.loading));

    final List<BookmarkObject> bookmarkList = await FileProcess.getBookmarkList();

    emit(BookmarkListState(
      code: bookmarkList.isEmpty ? BookmarkListStateCode.empty : BookmarkListStateCode.normal,
      bookmarkList: bookmarkList,
    ));
  }
}

class BookmarkListState extends Equatable {
  final BookmarkListStateCode code;
  final List<BookmarkObject> bookmarkList;

  const BookmarkListState({
    this.code = BookmarkListStateCode.unload,
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

  @override
  List<Object?> get props => [bookmarkList];
}
