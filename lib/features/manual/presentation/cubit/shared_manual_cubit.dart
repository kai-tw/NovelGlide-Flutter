import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/loading_state_code.dart';
import '../../../locale_system/domain/entities/app_locale.dart';
import '../../domain/entities/shared_manual_file_path.dart';
import '../../domain/use_cases/manual_load_use_case.dart';
import 'shared_manual_state.dart';

class SharedManualCubit extends Cubit<SharedManualState> {
  SharedManualCubit(
    this._loadUseCase,
  ) : super(const SharedManualState());

  final ManualLoadUseCase _loadUseCase;

  Future<void> loadManual(
      SharedManualFilePath filePath, AppLocale appLocale) async {
    emit(state.copyWith(code: LoadingStateCode.loading));

    final String? markdown = await _loadUseCase(ManualLoadUseCaseParam(
      filePath: filePath,
      appLocale: appLocale,
    ));

    if (markdown == null) {
      // Unable to load the markdown string
      if (!isClosed) {
        emit(state.copyWith(code: LoadingStateCode.error));
      }
    } else {
      if (!isClosed) {
        emit(state.copyWith(
          code: LoadingStateCode.loaded,
          markdown: markdown,
        ));
      }
    }
  }
}
