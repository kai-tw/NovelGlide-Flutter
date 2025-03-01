import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data_model/book_data.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/sort_order_code.dart';
import '../../../preference_keys/preference_keys.dart';
import '../../../repository/book_repository.dart';
import '../../../utils/book_utils.dart';
import '../../../utils/file_path.dart';
import '../../../utils/mime_resolver.dart';
import '../../common_components/common_list/list_template.dart';

class BookshelfCubit extends CommonListCubit<BookData> {
  final _sortOrderKey = PreferenceKeys.bookshelf.sortOrder;
  final _isAscendingKey = PreferenceKeys.bookshelf.isAscending;
  late final SharedPreferences _prefs;
  bool _isInitialized = false;

  factory BookshelfCubit() {
    final cubit = BookshelfCubit._(const CommonListState());
    cubit._init();
    return cubit;
  }

  BookshelfCubit._(super.initialState);

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  @override
  Future<void> refresh() async {
    if (!_isInitialized) {
      return;
    }

    final sortOrder =
        SortOrderCode.fromString(_prefs.getString(_sortOrderKey)) ??
            SortOrderCode.name;
    final isAscending = _prefs.getBool(_isAscendingKey) ?? true;

    final folder = Directory(FilePath.libraryRoot);
    final fileList = folder
        .listSync()
        .whereType<File>()
        .where((e) => MimeResolver.lookupAll(e) == 'application/epub+zip');
    List<BookData> list = [];

    // Only read the books that are not read yet.
    for (File epubFile in fileList) {
      final target = state.dataList
              .firstWhereOrNull((e) => e.absoluteFilePath == epubFile.path) ??
          await BookRepository.get(epubFile.path);
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

  void setListOrder({SortOrderCode? sortOrder, bool? isAscending}) {
    final order = sortOrder ?? state.sortOrder;
    final ascending = isAscending ?? state.isAscending;

    _prefs.setString(_sortOrderKey, order.toString());
    _prefs.setBool(_isAscendingKey, ascending);

    state.dataList.sort(BookUtils.sortCompare(order, ascending));
    emit(state.copyWith(
      isAscending: ascending,
      sortOrder: order,
    ));
  }

  bool deleteSelectedBooks() {
    List<BookData> newList = List<BookData>.from(state.dataList);
    for (BookData bookData in state.selectedSet) {
      BookRepository.delete(bookData.absoluteFilePath);
      newList.remove(bookData);
    }
    emit(state.copyWith(dataList: newList));
    return true;
  }

  bool deleteBook(BookData bookData) {
    final isSuccess = BookRepository.delete(bookData.absoluteFilePath);

    List<BookData> newList = List<BookData>.from(state.dataList);
    newList.remove(bookData);
    emit(state.copyWith(dataList: newList));
    return isSuccess;
  }
}
