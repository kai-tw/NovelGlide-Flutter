part of 'reader_cubit.dart';

class ReaderSearchState extends Equatable {
  final LoadingStateCode code;
  final ReaderSearchRangeCode range;
  final String query;
  final List<ReaderSearchResultData> resultList;

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
    this.range = ReaderSearchRangeCode.currentChapter,
    this.resultList = const [],
  });

  ReaderSearchState copyWith({
    LoadingStateCode? code,
    String? query,
    ReaderSearchRangeCode? range,
    List<ReaderSearchResultData>? resultList,
  }) {
    return ReaderSearchState(
      code: code ?? this.code,
      query: query ?? this.query,
      range: range ?? this.range,
      resultList: resultList ?? this.resultList,
    );
  }
}
