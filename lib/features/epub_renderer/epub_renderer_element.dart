import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xml/xml.dart' as xml;

import '../reader/bloc/reader_cubit.dart';
import '../reader/bloc/reader_state.dart';

class EpubRendererElement extends StatelessWidget {
  final xml.XmlNode element;

  const EpubRendererElement({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    switch (element.nodeType) {
      case xml.XmlNodeType.ELEMENT:
        return _renderElement(context, element as xml.XmlElement);
      case xml.XmlNodeType.TEXT:
        return _renderText(context, element as xml.XmlText);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _renderText(BuildContext context, xml.XmlText text) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      buildWhen: (previous, current) => previous.readerSettings != current.readerSettings,
      builder: (context, state) {
        return Text(
          text.value.replaceAll(RegExp(r'\n+'), ' '),
          style: TextStyle(
            fontSize: state.readerSettings.fontSize,
            height: state.readerSettings.lineHeight,
          ),
        );
      }
    );
  }

  Widget _renderElement(BuildContext context, xml.XmlElement element) {
    final double fontSize = MediaQuery.of(context).textScaler.scale(Theme.of(context).textTheme.bodySmall?.fontSize ?? 14.0);
    List<Widget> children = [];

    for (final child in element.children) {
      children.add(EpubRendererElement(element: child));
    }

    switch (element.name.local) {
      case 'p':
        return Padding(
          padding: EdgeInsets.symmetric(vertical: fontSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: children,
          ),
        );

      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: children,
        );
    }
  }
}
