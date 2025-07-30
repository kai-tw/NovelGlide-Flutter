import 'dart:async';

import 'package:collection/collection.dart';

import '../../../../../core/services/preference_service/preference_service.dart';
import '../../../../../core/shared_components/shared_list/shared_list.dart';
import '../../../../../enum/loading_state_code.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../book_service.dart';

typedef BookshelfState = SharedListState<BookData>;

class BookshelfCubit extends SharedListCubit<BookData> {
  factory BookshelfCubit() {
    final BookshelfCubit cubit = BookshelfCubit._();

    // Refresh at first.
    cubit.refresh();

    // Listen to book changes.
    cubit.onRepositoryChangedSubscription = BookService
        .repository.onChangedController.stream
        .listen((_) => cubit.refresh());

    // Listen to bookshelf preference changes.
    cubit.onPreferenceChangedSubscription = PreferenceService
        .bookshelf.onChangedController.stream
        .listen((_) => cubit.refreshPreference());
    return cubit;
  }

  BookshelfCubit._() : super(const BookshelfState());

  StreamSubscription<BookData>? _listStreamSubscription;

  @override
  Future<void> refresh() async {
    if (state.code.isLoading || state.code.isBackgroundLoading) {
      return;
    }

    // Load preferences.
    final SharedListData preference = await PreferenceService.bookshelf.load();
    emit(state.copyWith());

    final List<BookData> list = <BookData>[];

    emit(BookshelfState(
      code: LoadingStateCode.loading,
      dataList: list,
      sortOrder: preference.sortOrder,
      isAscending: preference.isAscending,
      listType: preference.listType,
    ));

    // Load books.
    _listStreamSubscription = BookService.repository.getBookList().listen(
      (BookData bookData) {
        list.add(bookData);

        if (!isClosed) {
          emit(state.copyWith(
            code: LoadingStateCode.backgroundLoading,
            dataList: sortList(
              list,
              preference.sortOrder,
              preference.isAscending,
            ), // Make a copy.
          ));
        }
      },
      onDone: () {
        if (!isClosed) {
          emit(state.copyWith(code: LoadingStateCode.loaded));
        }
      },
    );
  }

  bool deleteSelectedBooks() {
    final List<BookData> newList = List<BookData>.from(state.dataList);
    for (BookData bookData in state.selectedSet) {
      BookService.repository.delete(bookData);
      newList.remove(bookData);
    }
    emit(state.copyWith(dataList: newList));
    return true;
  }

  bool deleteBook(BookData bookData) {
    final bool isSuccess = BookService.repository.delete(bookData);

    final List<BookData> newList = List<BookData>.from(state.dataList);
    newList.remove(bookData);
    emit(state.copyWith(dataList: newList));
    return isSuccess;
  }

  @override
  void savePreference() {
    PreferenceService.bookshelf.save(SharedListData(
      sortOrder: state.sortOrder,
      isAscending: state.isAscending,
      listType: state.listType,
    ));
  }

  @override
  int sortCompare(
    BookData a,
    BookData b, {
    required SortOrderCode sortOrder,
    required bool isAscending,
  }) {
    switch (sortOrder) {
      case SortOrderCode.modifiedDate:
        return isAscending
            ? a.modifiedDate.compareTo(b.modifiedDate)
            : b.modifiedDate.compareTo(a.modifiedDate);

      default:
        return isAscending
            ? compareNatural(a.name, b.name)
            : compareNatural(b.name, a.name);
    }
  }

  @override
  Future<void> refreshPreference() async {
    final SharedListData preference = await PreferenceService.bookshelf.load();
    emit(state.copyWith(
      sortOrder: preference.sortOrder,
      isAscending: preference.isAscending,
      listType: preference.listType,
    ));
  }

  @override
  Future<void> close() {
    // Cancel all streams.
    _listStreamSubscription?.cancel();
    onRepositoryChangedSubscription.cancel();
    return super.close();
  }
}
