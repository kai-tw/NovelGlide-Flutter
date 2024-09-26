import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/loading_state_code.dart';
import 'reader_cubit.dart';
import 'reader_search_result.dart';

class ReaderSearchCubit extends Cubit<ReaderSearchState> {
  final ReaderCubit _readerCubit;

  set searchQuery(String query) => emit(state.copyWith(query: query));

  set setState(ReaderSearchState state) => emit(state);

  set searchRange(ReaderSearchRange range) => emit(state.copyWith(range: range));

  ReaderSearchCubit(this._readerCubit) : super(const ReaderSearchState());

  void init() {
    _readerCubit.searchCubit = this;
  }

  void startSearch() {
    emit(state.copyWith(code: LoadingStateCode.loading));
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
    _readerCubit.webViewHandler.controller.runJavaScript('window.readerApi.search("$query")');
  }

  void searchInCurrentChapter(String query) {
    _readerCubit.webViewHandler.controller.runJavaScript('window.readerApi.searchInCurrentChapter("$query")');
  }

  @override
  Future<void> close() async {
    _readerCubit.searchCubit = null;
    super.close();
  }
}

class ReaderSearchState extends Equatable {
  final LoadingStateCode code;
  final ReaderSearchRange range;
  final String query;
  final List<ReaderSearchResult> searchResultList;

  @override
  List<Object?> get props => [code, range, query, searchResultList];

  const ReaderSearchState({
    this.code = LoadingStateCode.initial,
    this.query = '',
    this.range = ReaderSearchRange.currentChapter,
    this.searchResultList = const [],
  });

  ReaderSearchState copyWith({
    LoadingStateCode? code,
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

enum ReaderSearchRange { currentChapter, all }
