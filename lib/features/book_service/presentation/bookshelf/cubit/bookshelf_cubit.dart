import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/services/file_path.dart';
import '../../../../../core/services/mime_resolver.dart';
import '../../../../../core/shared_components/shared_list/shared_list.dart';
import '../../../../../enum/loading_state_code.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../book_service.dart';

typedef BookshelfState = SharedListState<BookData>;

class BookshelfCubit extends SharedListCubit<BookData> {
  factory BookshelfCubit() {
    final BookshelfCubit cubit = BookshelfCubit._(const BookshelfState());
    WidgetsBinding.instance.addPostFrameCallback((_) => cubit.refresh());
    return cubit;
  }

  BookshelfCubit._(super.initialState);

  @override
  Future<void> refresh() async {
    if (state.code.isLoading || state.code.isBackgroundLoading) {
      return;
    }

    // Load preferences.
    await BookService.preference.load();

    emit(BookshelfState(
      code: LoadingStateCode.loading,
      dataList: List<BookData>.from(state.dataList),
      sortOrder: BookService.preference.sortOrder,
      isAscending: BookService.preference.isAscending,
    ));

    // Load books.
    final Directory folder = Directory(FilePath.libraryRoot);
    final Iterable<File> fileList = folder
        .listSync()
        .whereType<File>()
        .where((File e) => MimeResolver.lookupAll(e) == 'application/epub+zip');

    if (fileList.isNotEmpty) {
      final List<BookData> list = <BookData>[];
      final List<BookData> oldList = List<BookData>.from(state.dataList);

      // Only read the books that are not read yet.
      for (File epubFile in fileList) {
        final BookData target = oldList.firstWhereOrNull(
                (BookData e) => e.absoluteFilePath == epubFile.path) ??
            await BookService.repository.getBookData(epubFile.path);

        list.add(target);
        list.sort(BookData.sortCompare(BookService.preference.sortOrder,
            BookService.preference.isAscending));

        if (!isClosed) {
          emit(state.copyWith(
            code: LoadingStateCode.backgroundLoading,
            dataList: List<BookData>.from(list), // Make a copy.
          ));
        }
      }
    }

    if (!isClosed) {
      emit(state.copyWith(code: LoadingStateCode.loaded));
    }
  }

  @override
  void setListOrder({SortOrderCode? sortOrder, bool? isAscending}) {
    final SortOrderCode order = sortOrder ?? state.sortOrder;
    final bool ascending = isAscending ?? state.isAscending;

    BookService.preference.sortOrder = order;
    BookService.preference.isAscending = ascending;

    state.dataList.sort(BookData.sortCompare(order, ascending));
    emit(state.copyWith(
      isAscending: ascending,
      sortOrder: order,
    ));
  }

  bool deleteSelectedBooks() {
    final List<BookData> newList = List<BookData>.from(state.dataList);
    for (BookData bookData in state.selectedSet) {
      BookService.repository.delete(bookData.absoluteFilePath);
      newList.remove(bookData);
    }
    emit(state.copyWith(dataList: newList));
    return true;
  }

  bool deleteBook(BookData bookData) {
    final bool isSuccess =
        BookService.repository.delete(bookData.absoluteFilePath);

    final List<BookData> newList = List<BookData>.from(state.dataList);
    newList.remove(bookData);
    emit(state.copyWith(dataList: newList));
    return isSuccess;
  }
}
