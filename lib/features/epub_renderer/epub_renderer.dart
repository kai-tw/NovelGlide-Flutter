import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import 'helper/epub_renderer_xml_helper.dart';
import 'epub_renderer_element.dart';

class EpubRenderer extends StatelessWidget {
  final epub.EpubBook epubBook;
  final String htmlContent;

  const EpubRenderer({super.key, required this.htmlContent, required this.epubBook});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> cssFiles =
        (epubBook.Content?.Css ?? {}).map((key, value) => MapEntry(key, value.Content ?? ''));
    final xml.XmlDocument document = xml.XmlDocument.parse(htmlContent);
    EpubRendererXmlHelper.treeShake(document);

    print(cssFiles);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: EpubRendererElement(element: document.rootElement.getElement('body')!),
      ),
    );
  }
}
