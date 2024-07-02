import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReaderSettingsResetButtonCubit extends Cubit<ReaderSettingsResetButtonState> {
  final Color defaultColor;
  final String defaultText;
  final String doneText;

  ReaderSettingsResetButtonCubit({required this.defaultColor, required this.defaultText, required this.doneText})
      : super(ReaderSettingsResetButtonState(color: defaultColor, text: defaultText));

  void onPressedHandler() async {
    emit(ReaderSettingsResetButtonState(
      isDisabled: true,
      iconData: Icons.check_rounded,
      text: doneText,
      color: Colors.green,
    ));
    await Future.delayed(const Duration(seconds: 2));
    if (!isClosed) {
      emit(ReaderSettingsResetButtonState(
        isDisabled: false,
        text: defaultText,
        color: defaultColor,
      ));
    }
  }
}

class ReaderSettingsResetButtonState extends Equatable {
  final bool isDisabled;
  final IconData iconData;
  final String text;
  final Color color;

  @override
  List<Object?> get props => [
        isDisabled,
        iconData,
        text,
        color,
      ];

  const ReaderSettingsResetButtonState({
    this.isDisabled = false,
    this.iconData = Icons.restart_alt_rounded,
    required this.text,
    required this.color,
  });
}
