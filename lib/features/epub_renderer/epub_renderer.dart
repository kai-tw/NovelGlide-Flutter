import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import 'helper/epub_renderer_css.dart';
import 'helper/epub_renderer_xml_helper.dart';
import 'epub_renderer_element.dart';

class EpubRenderer extends StatelessWidget {
  final epub.EpubBook epubBook;
  final String htmlContent;

  const EpubRenderer({super.key, required this.htmlContent, required this.epubBook});

  @override
  Widget build(BuildContext context) {
    final Map<String, epub.EpubTextContentFile> epubCssFiles = epubBook.Content?.Css ?? {};
    final Map<String, String> cssFiles = epubCssFiles.map((key, value) => MapEntry(key, value.Content ?? ''));
    final Map<String, Map<String, EpubRendererCSS>> epubRendererCSS = cssFiles.map((key, value) {
      value = EpubRendererCSS.removeComments(value);
      Map<String, EpubRendererCSS> map = {};
      for (String itemValue in value.split('}').where((e) => e.isNotEmpty && e.contains('{')).toList()) {
        itemValue += '}';
        EpubRendererCSS css = EpubRendererCSS.fromCSS(itemValue);
        map[css.selector] = css;
      }
      return MapEntry(key, map);
    });

    // print(epubRendererCSS);

    final xml.XmlDocument document = xml.XmlDocument.parse(htmlContent);
    EpubRendererXmlHelper.treeShake(document);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: EpubRendererElement(element: document.rootElement.getElement('body')!),
      ),
    );
  }
}
