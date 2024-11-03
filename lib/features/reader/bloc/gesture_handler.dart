part of '../reader.dart';

class _GestureHandler {
  static const double sensitivity = 50;
  final _ReaderCubit readerCubit;
  double? startDragX;

  _GestureHandler(this.readerCubit);

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
