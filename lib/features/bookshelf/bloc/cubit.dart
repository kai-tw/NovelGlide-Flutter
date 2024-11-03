part of '../bookshelf.dart';

typedef _State = CommonListState<BookData>;

class BookshelfCubit extends Cubit<CommonListState<BookData>> {
  final String _sortOrderKey = PreferenceKeys.bookshelf.sortOrder;
  final String _isAscendingKey = PreferenceKeys.bookshelf.isAscending;

  factory BookshelfCubit() {
    final cubit = BookshelfCubit._internal(const CommonListState());
    WidgetsBinding.instance.addPostFrameCallback((_) => cubit.refresh());
    return cubit;
  }

  BookshelfCubit._internal(super.initialState);

  Future<void> refresh() async {
    emit(const CommonListState(code: LoadingStateCode.loading));

    // Load the sorting preferences.
    final prefs = await SharedPreferences.getInstance();
    final sortOrder = SortOrderCode.fromString(prefs.getString(_sortOrderKey));
    final isAscending = prefs.getBool(_isAscendingKey) ?? true;

    final folder = Directory(FilePath.libraryRoot);
    final fileList = folder
        .listSync()
        .whereType<File>()
        .where((e) => MimeResolver.lookupAll(e) == 'application/epub+zip');
    List<BookData> list = [];

    // Only read the books that are not read yet.
    for (File epubFile in fileList) {
      final target =
          state.dataList.firstWhereOrNull((e) => e.filePath == epubFile.path) ??
              BookData.fromEpubBook(
                  epubFile.path, await EpubUtils.loadEpubBook(epubFile.path));
      list.add(target);
    }

    list.sort(BookUtils.sortCompare(sortOrder, isAscending));

    if (!isClosed) {
      emit(CommonListState(
        code: LoadingStateCode.loaded,
        sortOrder: sortOrder,
        dataList: list,
        isAscending: isAscending,
      ));
    }
  }

  void unfocused() {
    setSelecting(false);
    setDragging(false);
  }

  Future<void> setListOrder({
    SortOrderCode? sortOrder,
    bool? isAscending,
  }) async {
    final order = sortOrder ?? state.sortOrder;
    final ascending = isAscending ?? state.isAscending;

    // Save the sorting preferences.
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_sortOrderKey, order.toString());
    prefs.setBool(_isAscendingKey, ascending);

    state.dataList.sort(BookUtils.sortCompare(order, ascending));
    emit(state.copyWith(
      isAscending: ascending,
      sortOrder: order,
    ));
  }

  void setDragging(bool isDragging) {
    emit(state.copyWith(isDragging: isDragging));
  }

  void setSelecting(bool isSelecting) {
    emit(state.copyWith(isSelecting: isSelecting, selectedSet: const {}));
  }

  void selectBook(BookData bookData) {
    emit(state.copyWith(selectedSet: {...state.selectedSet, bookData}));
  }

  void selectAllBooks() {
    emit(state.copyWith(selectedSet: state.dataList.toSet()));
  }

  void deselectBook(BookData bookData) {
    Set<BookData> newSet = Set<BookData>.from(state.selectedSet);
    newSet.remove(bookData);

    emit(state.copyWith(selectedSet: newSet));
  }

  void deselectAllBooks() {
    emit(state.copyWith(selectedSet: const {}));
  }

  bool deleteSelectedBooks() {
    List<BookData> newList = List<BookData>.from(state.dataList);
    for (BookData bookData in state.selectedSet) {
      BookRepository.delete(bookData.filePath);
      newList.remove(bookData);
    }
    emit(state.copyWith(dataList: newList));
    return true;
  }

  bool deleteBook(BookData bookData) {
    final isSuccess = BookRepository.delete(bookData.filePath);

    // Update the book list
    List<BookData> newList = List<BookData>.from(state.dataList);
    newList.remove(bookData);
    emit(state.copyWith(dataList: newList));
    return isSuccess;
  }
}
