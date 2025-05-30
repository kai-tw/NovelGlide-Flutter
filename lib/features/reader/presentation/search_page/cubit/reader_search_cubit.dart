import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../reader_page/cubit/reader_cubit.dart';

part 'reader_search_range_code.dart';
part 'reader_search_result_data.dart';
part 'reader_search_state.dart';

class ReaderSearchCubit extends Cubit<ReaderSearchState> {
  factory ReaderSearchCubit({required ReaderWebViewHandler webViewHandler}) {
    final ReaderSearchCubit cubit =
        ReaderSearchCubit._(webViewHandler: webViewHandler);
    cubit.webViewHandler.register('setSearchResultList', cubit.setResultList);
    return cubit;
  }

  ReaderSearchCubit._({required this.webViewHandler})
      : super(const ReaderSearchState());
  final ReaderWebViewHandler webViewHandler;

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
            .map((dynamic e) =>
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
