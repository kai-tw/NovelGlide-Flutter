part of 'reader_cubit.dart';

class ReaderGestureHandler {
  ReaderGestureHandler({
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.sensitivity = 50,
  });

  final Function()? onSwipeLeft;
  final Function()? onSwipeRight;
  int sensitivity;
  double? _startDragX;

  void onStart(DragStartDetails details) {
    _startDragX = details.localPosition.dx;
  }

  void onEnd(DragEndDetails details) {
    final double endDragX = details.localPosition.dx;
    if (_startDragX != null) {
      if (_startDragX! + sensitivity < endDragX) {
        onSwipeLeft?.call();
      } else if (_startDragX! - sensitivity > endDragX) {
        onSwipeRight?.call();
      }
    }
    _startDragX = null;
  }

  void onCancel() {
    _startDragX = null;
  }
}
