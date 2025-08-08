import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../domain/entities/reader_search_result_data.dart';
import '../../../domain/use_cases/reader_observe_search_list_use_case.dart';
import '../../../domain/use_cases/reader_send_goto_use_case.dart';
import '../../../domain/use_cases/reader_send_search_in_current_chapter_use_case.dart';
import '../../../domain/use_cases/reader_send_search_in_whole_book_use_case.dart';

part 'reader_search_range_code.dart';
part 'reader_search_state.dart';

class ReaderSearchCubit extends Cubit<ReaderSearchState> {
  factory ReaderSearchCubit(
    ReaderSendSearchInCurrentChapterUseCase sendSearchInCurrentChapterUseCase,
    ReaderSendSearchInWholeBookUseCase sendSearchInWholeBookUseCase,
    ReaderSendGotoUseCase sendGotoUseCase,
    ReaderObserveSearchListUseCase observeSearchListUseCase,
  ) {
    final ReaderSearchCubit cubit = ReaderSearchCubit._(
      sendSearchInCurrentChapterUseCase,
      sendSearchInWholeBookUseCase,
      sendGotoUseCase,
    );

    // Setup resultList subscription.
    cubit._resultListSubscription =
        observeSearchListUseCase().listen(cubit._setResultList);

    return cubit;
  }

  ReaderSearchCubit._(
    this._sendSearchInCurrentChapterUseCase,
    this._sendSearchInWholeBookUseCase,
    this._sendGotoUseCase,
  ) : super(const ReaderSearchState());

  final ReaderSendSearchInCurrentChapterUseCase
      _sendSearchInCurrentChapterUseCase;
  final ReaderSendSearchInWholeBookUseCase _sendSearchInWholeBookUseCase;
  final ReaderSendGotoUseCase _sendGotoUseCase;

  /// Stream Subscriptions
  late final StreamSubscription<List<ReaderSearchResultData>>
      _resultListSubscription;

  void startSearch() {
    emit(state.copyWith(code: LoadingStateCode.loading));
    switch (state.range) {
      case ReaderSearchRangeCode.currentChapter:
        _sendSearchInCurrentChapterUseCase(state.query);
        break;
      case ReaderSearchRangeCode.all:
        _sendSearchInWholeBookUseCase(state.query);
        break;
    }
  }

  void setQuery(String query) {
    emit(state.copyWith(query: query.trim()));
  }

  void setRange(ReaderSearchRangeCode range) {
    emit(state.copyWith(range: range));
  }

  void _setResultList(List<ReaderSearchResultData> list) {
    emit(
      state.copyWith(
        code: LoadingStateCode.loaded,
        resultList: list,
      ),
    );
  }

  void goto(String cfi) => _sendGotoUseCase(cfi);

  @override
  Future<void> close() async {
    await _resultListSubscription.cancel();
    super.close();
  }
}
