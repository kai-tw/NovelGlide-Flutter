import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReaderSettingsResetButtonCubit extends Cubit<ReaderSettingsResetButtonState> {
  final Color defaultBackgroundColor;
  final Color defaultForegroundColor;
  final String defaultText;
  final String doneText;

  ReaderSettingsResetButtonCubit({
    required this.defaultBackgroundColor,
    required this.defaultForegroundColor,
    required this.defaultText,
    required this.doneText,
  }) : super(
          ReaderSettingsResetButtonState(
            backgroundColor: defaultBackgroundColor,
            foregroundColor: defaultForegroundColor,
            text: defaultText,
          ),
        );

  void onPressedHandler() async {
    emit(ReaderSettingsResetButtonState(
      isDisabled: true,
      iconData: Icons.check_rounded,
      text: doneText,
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ));
    await Future.delayed(const Duration(seconds: 2));
    if (!isClosed) {
      emit(ReaderSettingsResetButtonState(
        isDisabled: false,
        text: defaultText,
        backgroundColor: defaultBackgroundColor,
        foregroundColor: defaultForegroundColor,
      ));
    }
  }
}

class ReaderSettingsResetButtonState extends Equatable {
  final bool isDisabled;
  final IconData iconData;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  List<Object?> get props => [
        isDisabled,
        iconData,
        text,
        backgroundColor,
        foregroundColor,
      ];

  const ReaderSettingsResetButtonState({
    this.isDisabled = false,
    this.iconData = Icons.restart_alt_rounded,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
  });
}
