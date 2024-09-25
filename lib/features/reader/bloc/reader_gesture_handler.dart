import 'package:flutter/gestures.dart';

import 'reader_cubit.dart';

class ReaderGestureHandler {
  static const double sensitivity = 50;
  final ReaderCubit readerCubit;
  double? startDragX;

  ReaderGestureHandler(this.readerCubit);

  void onStart(DragStartDetails details) {
    startDragX = details.localPosition.dx;
  }

  void onEnd(DragEndDetails details) {
    final double endDragX = details.localPosition.dx;
    if (startDragX != null && startDragX! + sensitivity < endDragX) {
      if (readerCubit.state.isRtl) {
        readerCubit.nextPage();
      } else {
        readerCubit.prevPage();
      }
    } else if (startDragX != null && startDragX! - sensitivity > endDragX) {
      if (readerCubit.state.isRtl) {
        readerCubit.prevPage();
      } else {
        readerCubit.nextPage();
      }
    }
    startDragX = null;
  }

  void onCancel() {
    startDragX = null;
  }
}
