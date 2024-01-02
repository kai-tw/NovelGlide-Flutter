import 'package:flutter/material.dart';
import 'package:novelglide/core/stream_builder.dart';
import 'package:novelglide/core/stream_builder_utility.dart';

class StreamBuilderWidget<T> extends StatefulWidget {
  final CustomStreamBuilder<T> customStreamBuilder;
  final Widget Function(T t) builder;
  final T? initialData;

  const StreamBuilderWidget(
      {super.key,
      required this.customStreamBuilder,
      required this.builder,
      required this.initialData});

  @override
  State<StreamBuilderWidget> createState() => _StreamBuilderWidgetState<T>();
}

class _StreamBuilderWidgetState<T> extends State<StreamBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        initialData: widget.initialData,
        stream: widget.customStreamBuilder.getStream,
        builder: (context, n) {
          return widget.builder(n.data as T);
        });
  }

  @override
  void dispose() {
    super.dispose();
    widget.customStreamBuilder.dispose();
    StreamBuilderUtility.instance.disposeByKey(widget.customStreamBuilder.key);
  }
}
