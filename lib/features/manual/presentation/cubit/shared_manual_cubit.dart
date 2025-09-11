import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/http_client/domain/use_cases/http_client_get_use_case.dart';
import '../../../../core/log_system/log_system.dart';
import '../../../../enum/loading_state_code.dart';
import 'shared_manual_state.dart';

class SharedManualCubit extends Cubit<SharedManualState> {
  SharedManualCubit(
    this._getUseCase,
  ) : super(const SharedManualState());

  final HttpClientGetUseCase _getUseCase;

  Future<void> loadManual(Uri uri) async {
    emit(state.copyWith(code: LoadingStateCode.loading));

    try {
      final String markdown = await _getUseCase(uri);

      if (!isClosed) {
        emit(state.copyWith(
          code: LoadingStateCode.loaded,
          markdown: markdown,
        ));
      }
    } catch (e, s) {
      LogSystem.error('Failed to load manual. ($uri)', error: e, stackTrace: s);
      if (!isClosed) {
        emit(state.copyWith(code: LoadingStateCode.error));
      }
    }
  }
}
