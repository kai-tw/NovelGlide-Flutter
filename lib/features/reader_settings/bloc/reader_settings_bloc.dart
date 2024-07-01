import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/reader_settings_data.dart';

class ReaderSettingsCubit extends Cubit<ReaderSettingsData> {
  ReaderSettingsCubit() : super(ReaderSettingsData.load());

  void setState({
    bool? autoSave,
    double? fontSize,
    double? lineHeight,
  }) {
    final ReaderSettingsData newState = state.copyWith(
      autoSave: autoSave ?? state.autoSave,
      fontSize: fontSize ?? state.fontSize,
      lineHeight: lineHeight ?? state.lineHeight,
    );
    emit(newState);
  }

  void save() {
    state.save();
  }

  void reset() {
    emit(const ReaderSettingsData()..save());
  }
}
