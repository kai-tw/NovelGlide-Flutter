import 'dart:async';

import 'package:flutter/material.dart';
import 'package:novelglide/core/stream_builder_widget.dart';

class CustomStreamBuilder<T> {
  late StreamController<T> _controller;
  T? t;
  final String key;

  CustomStreamBuilder(this.key) {
    _controller = StreamController.broadcast();
  }

  factory CustomStreamBuilder.instance(String key) {
    return CustomStreamBuilder<T>(key);
  }

  get getStream => _controller.stream;
  get data => t;

  void changeData(T t) {
    this.t = t;
    _controller.sink.add(t);
  }

  void dispose() {
    _controller.close();
  }

  Widget addObserver(Widget Function(T t) target, {required T initialData}) {
    this.t = data ?? initialData;

    return StreamBuilderWidget<T>(customStreamBuilder: this, builder: target, initialData: initialData);
  }
}