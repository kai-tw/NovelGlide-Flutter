import 'dart:convert';

import 'epub_renderer_css_data.dart';

class EpubRendererCSSNode {
  final String selector;
  final EpubRendererCSSData data;
  final Map<String, EpubRendererCSSNode> children;

  EpubRendererCSSNode({
    required this.selector,
    required this.data,
    required this.children,
  });

  factory EpubRendererCSSNode.fromCSS(String css) {
    return EpubRendererCSSNode._fromCSS(':root', css);
  }

  factory EpubRendererCSSNode._fromCSS(String selector, String css) {
    int start = 0, openBraceIndex = css.indexOf('{'), closeBraceIndex = css.indexOf('}');
    if (openBraceIndex == -1 || closeBraceIndex == -1) {
      throw EpubRendererCSSInvalidCSSException();
    }

    if (openBraceIndex == 0 && closeBraceIndex == css.length - 1) {
      return EpubRendererCSSNode(
        selector: selector,
        data: EpubRendererCSSData.fromCSSProperties(css),
        children: {},
      );
    }

    EpubRendererCSSNode node = EpubRendererCSSNode(
      selector: selector,
      data: EpubRendererCSSData.fromCSSProperties(css),
      children: {},
    );

    while (openBraceIndex != -1 && closeBraceIndex != -1) {
      List<String> selectors = css.substring(start, openBraceIndex).trim().split(',');
      String data = css.substring(openBraceIndex + 1, closeBraceIndex).trim();

      for (String item in selectors) {
        int spaceIndex = item.indexOf(' ');
        String selector = spaceIndex != -1 ? item.substring(0, spaceIndex) : item;
        String otherSelector = spaceIndex != -1 ? item.substring(spaceIndex + 1) : '';
        node.children[selector] = EpubRendererCSSNode._fromCSS(selector, '$otherSelector{$data}');
        break;
      }

      start = closeBraceIndex + 1;
      openBraceIndex = css.indexOf('{', start);
      closeBraceIndex = css.indexOf('}', start);
    }

    print(node.children);

    return node;
  }

  Map<String, dynamic> toJson() {
    return {
      'selector': selector,
      'data': data,
      'children': children,
    };
  }

  @override
  toString() {
    return json.encode(toJson());
  }
}

class EpubRendererCSSInvalidCSSException implements Exception {}
