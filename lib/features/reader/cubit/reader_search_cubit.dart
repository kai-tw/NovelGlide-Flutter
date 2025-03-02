part of 'reader_cubit.dart';

class ReaderSearchCubit extends Cubit<ReaderSearchState> {
  final Function(String)? searchInCurrentChapter;
  final Function(String)? searchInWholeBook;
  final Function(String)? goto;

  ReaderSearchCubit({
    this.searchInCurrentChapter,
    this.searchInWholeBook,
    this.goto,
  }) : super(const ReaderSearchState());

  void startSearch() {
    emit(state.copyWith(code: LoadingStateCode.loading));
    switch (state.range) {
      case ReaderSearchRange.currentChapter:
        searchInCurrentChapter?.call(state.query);
        break;
      case ReaderSearchRange.all:
        searchInWholeBook?.call(state.query);
        break;
    }
  }

  void setResultList(dynamic rawList) {
    assert(rawList is List<dynamic>);
    emit(
      state.copyWith(
        code: LoadingStateCode.loaded,
        resultList: _parseResultList(rawList),
      ),
    );
  }

  List<ReaderSearchResult> _parseResultList(List<dynamic> rawList) {
    return rawList
        .map((e) => ReaderSearchResult(cfi: e['cfi'], excerpt: e['excerpt']))
        .toList();
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
