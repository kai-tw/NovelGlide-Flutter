part of 'reader_cubit.dart';

class ReaderGestureHandler {
  ReaderGestureHandler({
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  final Function()? onSwipeLeft;
  final Function()? onSwipeRight;
  double? startDragX;

  void onStart(DragStartDetails details) {
    startDragX = details.localPosition.dx;
  }

  void onEnd(DragEndDetails details) {
    const int sensitivity = 50;
    final double endDragX = details.localPosition.dx;
    if (startDragX != null) {
      if (startDragX! + sensitivity < endDragX) {
        onSwipeLeft?.call();
      } else if (startDragX! - sensitivity > endDragX) {
        onSwipeRight?.call();
      }
    }
    startDragX = null;
  }

  void onCancel() {
    startDragX = null;
  }
}
