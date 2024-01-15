import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// Reference:
/// Source: https://github.com/letsar/flutter_slidable/issues/273#issuecomment-1065014638
class MotionListener extends StatefulWidget {
  final Function? onOpenStart;
  final Function? onOpenEnd;
  final Function? onClose;
  final Widget motionWidget;

  const MotionListener({super.key, this.onOpenStart, this.onOpenEnd, this.onClose, required this.motionWidget});

  @override
  MotionListenerState createState() => MotionListenerState();
}

class MotionListenerState extends State<MotionListener> {
  late SlidableController _controller;
  late void Function() _listener;
  bool _isClosed = true;

  void _initListener() {
    if ((_controller.ratio == 0) && !_isClosed) {
      _isClosed = true;
      if (widget.onClose != null){
        widget.onClose!();
      }
    }

    if ((_controller.ratio > 0) && _isClosed) {
      _isClosed = false;
      if (widget.onOpenStart != null) {
        widget.onOpenStart!();
      }
    }

    if ((_controller.ratio < 0) && _isClosed) {
      _isClosed = false;
      if (widget.onOpenEnd != null) {
        widget.onOpenEnd!();
      }
    }
  }

  @override
  void dispose() {
    _controller.animation.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = Slidable.of(context)!;
    _listener = _initListener;

    _controller.animation.addListener(_listener);

    return widget.motionWidget;
  }
}
