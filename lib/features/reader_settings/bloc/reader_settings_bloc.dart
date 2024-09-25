import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/reader_settings_data.dart';
import '../../reader/bloc/reader_cubit.dart';

class ReaderSettingsCubit extends Cubit<ReaderSettingsData> {
  final ReaderCubit readerCubit;

  ReaderSettingsCubit(this.readerCubit) : super(ReaderSettingsData.load());

  void setState({
    bool? autoSave,
    double? fontSize,
    double? lineHeight,
    bool? gestureDetection,
  }) {
    final ReaderSettingsData settings = state.copyWith(
      autoSave: autoSave,
      fontSize: fontSize,
      lineHeight: lineHeight,
      gestureDetection: gestureDetection,
    );
    emit(settings);
    readerCubit.setSettings(settings);
  }

  void save() {
    state.save();
  }

  void reset() {
    final ReaderSettingsData settings = const ReaderSettingsData()..save();
    emit(settings);
    readerCubit.setSettings(settings);
  }
}
