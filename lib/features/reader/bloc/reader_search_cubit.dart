import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'reader_cubit.dart';
import 'reader_search_result.dart';

class ReaderSearchCubit extends Cubit<ReaderSearchState> {
  final ReaderCubit readerCubit;

  set searchQuery(String query) => emit(state.copyWith(query: query));

  set setState(ReaderSearchState state) => emit(state);

  set searchRange(ReaderSearchRange range) => emit(state.copyWith(range: range));

  ReaderSearchCubit({required this.readerCubit}) : super(const ReaderSearchState());

  void startSearch() {
    emit(state.copyWith(code: ReaderSearchStateCode.loading));
    switch (state.range) {
      case ReaderSearchRange.currentChapter:
        searchInCurrentChapter(state.query);
        break;
      case ReaderSearchRange.all:
        search(state.query);
        break;
    }
  }

  /// Communication

  void search(String query) {
    readerCubit.webViewController.runJavaScript('window.readerApi.search("$query")');
  }

  void searchInCurrentChapter(String query) {
    readerCubit.webViewController.runJavaScript('window.readerApi.searchInCurrentChapter("$query")');
  }

  @override
  Future<void> close() async {
    readerCubit.searchCubit = null;
    super.close();
  }
}

class ReaderSearchState extends Equatable {
  final ReaderSearchStateCode code;
  final ReaderSearchRange range;
  final String query;
  final List<ReaderSearchResult> searchResultList;

  @override
  List<Object?> get props => [code, range, query, searchResultList];

  const ReaderSearchState({
    this.code = ReaderSearchStateCode.initial,
    this.query = '',
    this.range = ReaderSearchRange.currentChapter,
    this.searchResultList = const [],
  });

  ReaderSearchState copyWith({
    ReaderSearchStateCode? code,
    String? query,
    ReaderSearchRange? range,
    List<ReaderSearchResult>? searchResultList,
  }) {
    return ReaderSearchState(
      code: code ?? this.code,
      query: query ?? this.query,
      range: range ?? this.range,
      searchResultList: searchResultList ?? this.searchResultList,
    );
  }
}

enum ReaderSearchStateCode { initial, loading, loaded }

enum ReaderSearchRange { currentChapter, all }
