import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit() : super(const ReaderState());

  void loadSettings() {
    Box readerSetting = Hive.box(name: 'reader_settings');
    double fontSize = readerSetting.get('font_size') ?? 16.0;
    readerSetting.close();
    emit(ReaderState(fontSize: fontSize));
  }

  void applyPreview({double? fontSize}) {
    emit(state.copyWith(fontSize: fontSize));
  }
}

class ReaderState extends Equatable {
  final double fontSize;

  const ReaderState({this.fontSize = 16.0});

  ReaderState copyWith({
    double? fontSize,
  }) {
    return ReaderState(
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  List<Object?> get props => [fontSize];
}
