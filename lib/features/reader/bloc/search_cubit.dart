part of '../reader.dart';

class _SearchCubit extends Cubit<_SearchState> {
  final ReaderCubit readerCubit;
  final Logger _logger;

  factory _SearchCubit(ReaderCubit readerCubit, Logger logger) {
    const initialState = _SearchState();
    final cubit = _SearchCubit._internal(
      initialState,
      readerCubit,
      logger,
    );
    return cubit;
  }

  _SearchCubit._internal(
    super.initialState,
    this.readerCubit,
    this._logger,
  );

  void startSearch() {
    _logger.i('Start a search query.');
    emit(state.copyWith(code: LoadingStateCode.loading));
    switch (state.range) {
      case ReaderSearchRange.currentChapter:
        _searchInCurrentChapter(state.query);
        break;
      case ReaderSearchRange.all:
        _searchInWholeBook(state.query);
        break;
    }
  }

  /// Communication

  void _searchInWholeBook(String query) {
    _logger.i('Search "$query" in the whole book.');
    readerCubit._webViewHandler.controller
        .runJavaScript('window.readerApi.searchInWholeBook("$query")');
  }

  void _searchInCurrentChapter(String query) {
    _logger.i('Search "$query" in the current chapter.');
    readerCubit._webViewHandler.controller
        .runJavaScript('window.readerApi.searchInCurrentChapter("$query")');
  }

  void setResultList(dynamic rawList) {
    if (rawList is List) {
      _logger.i('Set the result list.');
      emit(
        state.copyWith(
          code: LoadingStateCode.loaded,
          resultList: _parseResultList(rawList),
        ),
      );
    }
  }

  List<_SearchResult> _parseResultList(List<dynamic> rawList) {
    return rawList
        .map((e) => _SearchResult(cfi: e['cfi'], excerpt: e['excerpt']))
        .toList();
  }

  void setQuery(String query) {
    emit(state.copyWith(query: query.trim()));
  }

  void setRange(ReaderSearchRange range) {
    emit(state.copyWith(range: range));
  }
}

class _SearchState extends Equatable {
  final LoadingStateCode code;
  final ReaderSearchRange range;
  final String query;
  final List<_SearchResult> resultList;

  @override
  List<Object?> get props => [
        code,
        range,
        query,
        resultList,
      ];

  const _SearchState({
    this.code = LoadingStateCode.initial,
    this.query = '',
    this.range = ReaderSearchRange.currentChapter,
    this.resultList = const [],
  });

  _SearchState copyWith({
    LoadingStateCode? code,
    String? query,
    ReaderSearchRange? range,
    List<_SearchResult>? resultList,
  }) {
    return _SearchState(
      code: code ?? this.code,
      query: query ?? this.query,
      range: range ?? this.range,
      resultList: resultList ?? this.resultList,
    );
  }
}

class _SearchResult extends Equatable {
  final String cfi;
  final String excerpt;

  @override
  List<Object?> get props => [cfi, excerpt];

  const _SearchResult({
    required this.cfi,
    required this.excerpt,
  });
}

enum ReaderSearchRange { currentChapter, all }
