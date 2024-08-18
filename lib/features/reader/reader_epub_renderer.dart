import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

class ReaderEpubRenderer extends StatelessWidget {
  final xml.XmlElement element;

  const ReaderEpubRenderer({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    if (element.children.isEmpty) {
      return Text(element.name.local);
    }

    List<Widget> children = [];
    for (final child in element.children) {
      if (child is xml.XmlElement) {
        children.add(ReaderEpubRenderer(element: child));
      } else if (child is xml.XmlText) {
        children.add(Text(child.value));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: children,
    );
  }
}
