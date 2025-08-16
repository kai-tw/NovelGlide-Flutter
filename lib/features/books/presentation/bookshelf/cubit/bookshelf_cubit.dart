import 'dart:async';

import 'package:collection/collection.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../../../enum/sort_order_code.dart';
import '../../../../../features/shared_components/shared_list/shared_list.dart';
import '../../../../preference/domain/entities/bookshelf_preference_data.dart';
import '../../../../preference/domain/use_cases/preference_get_use_cases.dart';
import '../../../../preference/domain/use_cases/preference_observe_change_use_case.dart';
import '../../../../preference/domain/use_cases/preference_save_use_case.dart';
import '../../../domain/entities/book.dart';
import '../../../domain/entities/book_cover.dart';
import '../../../domain/use_cases/book_delete_use_case.dart';
import '../../../domain/use_cases/book_exists_use_case.dart';
import '../../../domain/use_cases/book_get_cover_use_case.dart';
import '../../../domain/use_cases/book_get_list_use_case.dart';
import '../../../domain/use_cases/book_observe_change_use_case.dart';

typedef BookshelfState = SharedListState<Book>;

class BookshelfCubit extends SharedListCubit<Book> {
  factory BookshelfCubit(
    BookGetListUseCase getBookListUseCase,
    BookDeleteUseCase deleteBookUseCase,
    BookObserveChangeUseCase observeBookChangeUseCase,
    BookExistsUseCase bookExistsUseCase,
    BookGetCoverUseCase bookGetCoverUseCase,
    BookshelfGetPreferenceUseCase bookshelfGetPreferenceUseCase,
    BookshelfSavePreferenceUseCase bookshelfSavePreferenceUseCase,
    BookshelfObserveChangeUseCase bookshelfObserveChangeUseCase,
  ) {
    final BookshelfCubit cubit = BookshelfCubit._(
      getBookListUseCase,
      deleteBookUseCase,
      bookExistsUseCase,
      bookGetCoverUseCase,
      bookshelfGetPreferenceUseCase,
      bookshelfSavePreferenceUseCase,
    );

    // Refresh at first.
    cubit.refresh();

    // Listen to book changes.
    cubit.onRepositoryChangedSubscription =
        observeBookChangeUseCase().listen((_) => cubit.refresh());

    // Listen to bookshelf preference changes.
    cubit.onPreferenceChangedSubscription = bookshelfObserveChangeUseCase()
        .listen((_) => cubit.refreshPreference());
    return cubit;
  }

  BookshelfCubit._(
    this._getBookListUseCase,
    this._deleteBookUseCase,
    this._bookExistsUseCase,
    this._bookGetCoverUseCase,
    this._getPreferenceUseCase,
    this._savePreferenceUseCase,
  ) : super(const BookshelfState());

  /// Book management use cases
  final BookGetListUseCase _getBookListUseCase;
  final BookDeleteUseCase _deleteBookUseCase;
  final BookExistsUseCase _bookExistsUseCase;
  final BookGetCoverUseCase _bookGetCoverUseCase;

  /// Bookshelf preferences use cases
  final BookshelfGetPreferenceUseCase _getPreferenceUseCase;
  final BookshelfSavePreferenceUseCase _savePreferenceUseCase;

  /// Stream subscriptions
  StreamSubscription<Book>? _listStreamSubscription;

  @override
  Future<void> refresh() async {
    if (state.code.isLoading || state.code.isBackgroundLoading) {
      return;
    }

    // Load preferences.
    final BookshelfPreferenceData preference = await _getPreferenceUseCase();
    emit(state.copyWith());

    final List<Book> list = <Book>[];

    emit(BookshelfState(
      code: LoadingStateCode.loading,
      dataList: list,
      sortOrder: preference.sortOrder,
      isAscending: preference.isAscending,
      listType: preference.listType,
    ));

    // Load books.
    _listStreamSubscription = _getBookListUseCase().listen(
      (Book book) {
        list.add(book);

        if (!isClosed) {
          emit(state.copyWith(
            code: LoadingStateCode.backgroundLoading,
            dataList: sortList(
              list,
              preference.sortOrder,
              preference.isAscending,
            ),
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

  Future<bool> deleteSelectedBooks() async {
    final List<Book> newList = List<Book>.from(state.dataList);
    for (Book bookData in state.selectedSet) {
      await _deleteBookUseCase(bookData.identifier);
      newList.remove(bookData);
    }
    emit(state.copyWith(dataList: newList));
    return true;
  }

  Future<bool> deleteBook(Book bookData) async {
    final bool isSuccess = await _deleteBookUseCase(bookData.identifier);

    final List<Book> newList = List<Book>.from(state.dataList);
    newList.remove(bookData);
    emit(state.copyWith(dataList: newList));
    return isSuccess;
  }

  Future<bool> bookExists(Book bookData) =>
      _bookExistsUseCase(bookData.identifier);

  Future<BookCover> getCover(Book bookData) =>
      _bookGetCoverUseCase(bookData.identifier);

  @override
  void savePreference() {
    _savePreferenceUseCase(BookshelfPreferenceData(
      sortOrder: state.sortOrder,
      isAscending: state.isAscending,
      listType: state.listType,
    ));
  }

  @override
  int sortCompare(
    Book a,
    Book b, {
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
            ? compareNatural(a.title, b.title)
            : compareNatural(b.title, a.title);
    }
  }

  @override
  Future<void> refreshPreference() async {
    final BookshelfPreferenceData preference = await _getPreferenceUseCase();
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
    return super.close();
  }
}
