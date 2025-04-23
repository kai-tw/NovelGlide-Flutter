part of 'reader_cubit.dart';

class ReaderSearchCubit extends Cubit<ReaderSearchState> {
  final ReaderWebViewHandler webViewHandler;

  factory ReaderSearchCubit({required ReaderWebViewHandler webViewHandler}) {
    final cubit = ReaderSearchCubit._(webViewHandler: webViewHandler);
    cubit.webViewHandler.register('setSearchResultList', cubit.setResultList);
    return cubit;
  }

  ReaderSearchCubit._({required this.webViewHandler})
      : super(const ReaderSearchState());

  void startSearch() {
    emit(state.copyWith(code: LoadingStateCode.loading));
    switch (state.range) {
      case ReaderSearchRangeCode.currentChapter:
        webViewHandler.searchInCurrentChapter(state.query);
        break;
      case ReaderSearchRangeCode.all:
        webViewHandler.searchInWholeBook(state.query);
        break;
    }
  }

  void setResultList(dynamic jsonValue) {
    assert(jsonValue is Map<String, dynamic>);
    final List<dynamic> rawList = jsonValue['searchResultList'];

    emit(
      state.copyWith(
        code: LoadingStateCode.loaded,
        resultList: rawList
            .map((e) =>
                ReaderSearchResultData(cfi: e['cfi'], excerpt: e['excerpt']))
            .toList(),
      ),
    );
  }

  void setQuery(String query) {
    emit(state.copyWith(query: query.trim()));
  }

  void setRange(ReaderSearchRangeCode range) {
    emit(state.copyWith(range: range));
  }
}
