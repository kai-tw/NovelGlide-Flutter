import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReaderAddBookmarkButtonCubit extends Cubit<ReaderAddBookmarkButtonState> {
  ReaderAddBookmarkButtonCubit() : super(const ReaderAddBookmarkButtonState());

  void onPressedHandler() async {
    emit(const ReaderAddBookmarkButtonState(
      isDisabled: true,
      iconData: Icons.check_rounded,
      disabledColor: Colors.green,
    ));
    await Future.delayed(const Duration(seconds: 1));
    if (!isClosed) {
      emit(const ReaderAddBookmarkButtonState());
    }
  }
}

class ReaderAddBookmarkButtonState extends Equatable {
  final bool isDisabled;
  final IconData iconData;
  final Color? disabledColor;

  @override
  List<Object?> get props => [
        isDisabled,
        iconData,
        disabledColor,
      ];

  const ReaderAddBookmarkButtonState({
    this.isDisabled = false,
    this.iconData = Icons.bookmark_add_rounded,
    this.disabledColor,
  });
}
