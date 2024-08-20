import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import '../../toolbox/css_helper.dart';
import '../../toolbox/xml_helper.dart';
import 'css/epub_renderer_css_node.dart';
import 'epub_renderer_element.dart';

class EpubRenderer extends StatelessWidget {
  final epub.EpubBook epubBook;
  final String htmlContent;

  const EpubRenderer({super.key, required this.htmlContent, required this.epubBook});

  @override
  Widget build(BuildContext context) {
    final Map<String, epub.EpubTextContentFile> epubCssFiles = epubBook.Content?.Css ?? {};
    final Map<String, String> cssFiles = epubCssFiles.map((key, value) => MapEntry(key, value.Content ?? ''));

    cssFiles.forEach((key, value) {
      print("----------");
      value = CSSHelper.removeComments(value);
      EpubRendererCSSNode node = EpubRendererCSSNode.fromCSS(value);
    });

    final xml.XmlDocument document = xml.XmlDocument.parse(htmlContent);
    XmlHelper.treeShake(document);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: EpubRendererElement(element: document.rootElement.getElement('body')!),
      ),
    );
  }
}
