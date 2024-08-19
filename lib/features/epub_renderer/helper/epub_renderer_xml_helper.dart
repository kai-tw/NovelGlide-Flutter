import 'package:xml/xml.dart';

class EpubRendererXmlHelper {
  static void treeShake(XmlDocument document) {
    _treeShake(document.rootElement);
  }

  static void _treeShake(XmlElement element) {
    element.children.removeWhere((child) {
      return child is XmlText && child.value.trim().isEmpty;
    });

    for (final child in element.children) {
      if (child is XmlElement) {
        _treeShake(child);
      }
    }
  }
}