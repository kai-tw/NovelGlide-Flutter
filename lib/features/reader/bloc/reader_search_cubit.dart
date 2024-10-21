import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../enum/loading_state_code.dart';
import 'reader_cubit.dart';

class ReaderSearchCubit extends Cubit<ReaderSearchState> {
  final ReaderCubit _readerCubit;
  final Logger _logger;

  factory ReaderSearchCubit(ReaderCubit readerCubit, Logger logger) {
    const initialState = ReaderSearchState();
    final cubit = ReaderSearchCubit._internal(
      initialState,
      readerCubit,
      logger,
    );
    return cubit;
  }

  ReaderSearchCubit._internal(
    super.initialState,
    this._readerCubit,
    this._logger,
  );

  void startSearch() {
    _logger.i('Start a search query.');
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
    _logger.i('Search "$query" in the whole book.');
    _readerCubit.webViewHandler.controller
        .runJavaScript('window.readerApi.search("$query")');
  }

  void searchInCurrentChapter(String query) {
    _logger.i('Search "$query" in the current chapter.');
    _readerCubit.webViewHandler.controller
        .runJavaScript('window.readerApi.searchInCurrentChapter("$query")');
  }

  void setResultList(List<ReaderSearchResult> resultList) {
    _logger.i('Set the result list.');
    emit(
      state.copyWith(
        code: LoadingStateCode.loaded,
        resultList: resultList,
      ),
    );
  }

  void setQuery(String query) {
    emit(state.copyWith(query: query.trim()));
  }

  void setRange(ReaderSearchRange range) {
    emit(state.copyWith(range: range));
  }
}

class ReaderSearchState extends Equatable {
  final LoadingStateCode code;
  final ReaderSearchRange range;
  final String query;
  final List<ReaderSearchResult> resultList;

  @override
  List<Object?> get props => [
        code,
        range,
        query,
        resultList,
      ];

  const ReaderSearchState({
    this.code = LoadingStateCode.initial,
    this.query = '',
    this.range = ReaderSearchRange.currentChapter,
    this.resultList = const [],
  });

  ReaderSearchState copyWith({
    LoadingStateCode? code,
    String? query,
    ReaderSearchRange? range,
    List<ReaderSearchResult>? resultList,
  }) {
    return ReaderSearchState(
      code: code ?? this.code,
      query: query ?? this.query,
      range: range ?? this.range,
      resultList: resultList ?? this.resultList,
    );
  }
}

class ReaderSearchResult extends Equatable {
  final String cfi;
  final String excerpt;

  @override
  List<Object?> get props => [cfi, excerpt];

  const ReaderSearchResult({
    required this.cfi,
    required this.excerpt,
  });
}

enum ReaderSearchRange { currentChapter, all }
