import 'dart:convert';

import 'package:flutter/material.dart';

class EpubRendererCSSData {
  String marginTop;
  String marginBottom;
  String marginLeft;
  String marginRight;
  String paddingTop;
  String paddingBottom;
  String paddingLeft;
  String paddingRight;
  String fontSize;
  FontWeight fontWeight;
  FontStyle fontStyle;
  String fontFamily;
  EpubRendererCSSFontVariant fontVariant;
  TextAlign textAlign;
  double lineHeight;
  double letterSpacing;

  EpubRendererCSSData({
    this.marginTop = '0',
    this.marginBottom = '0',
    this.marginLeft = '0',
    this.marginRight = '0',
    this.paddingTop = '0',
    this.paddingBottom = '0',
    this.paddingLeft = '0',
    this.paddingRight = '0',
    this.fontSize = '14',
    this.fontWeight = FontWeight.w400,
    this.fontStyle = FontStyle.normal,
    this.fontFamily = "",
    this.fontVariant = EpubRendererCSSFontVariant.normal,
    this.textAlign = TextAlign.start,
    this.lineHeight = 1.2,
    this.letterSpacing = 0,
  });

  factory EpubRendererCSSData.fromCSSProperties(String cssProperties) {
    // Initialize variables
    EpubRendererCSSData epubRendererCSS = EpubRendererCSSData();

    // Split the CSS properties by ';'
    final Iterable<RegExpMatch> propMatches = RegExp(r'([a-z-]+)\s*:\s*([^;]+)').allMatches(cssProperties);
    for (final RegExpMatch cssProperty in propMatches) {
      final String propertyName = cssProperty.group(1)?.trim() ?? '';
      final String propertyValue = cssProperty.group(2)?.trim() ?? '';
      if (propertyName.isEmpty || propertyValue.isEmpty) {
        continue;
      }

      switch (propertyName) {
        case 'margin':
          List<String> marginValues = propertyValue.split(' ');

          switch (marginValues.length) {
            case 1:
              epubRendererCSS.marginTop = propertyValue;
              epubRendererCSS.marginBottom = propertyValue;
              epubRendererCSS.marginLeft = propertyValue;
              epubRendererCSS.marginRight = propertyValue;
              break;
            case 2:
              epubRendererCSS.marginTop = marginValues[0];
              epubRendererCSS.marginBottom = marginValues[0];
              epubRendererCSS.marginLeft = marginValues[1];
              epubRendererCSS.marginRight = marginValues[1];
              break;
            case 3:
              epubRendererCSS.marginTop = marginValues[0];
              epubRendererCSS.marginBottom = marginValues[1];
              epubRendererCSS.marginLeft = marginValues[2];
              epubRendererCSS.marginRight = marginValues[2];
              break;
            case 4:
              epubRendererCSS.marginTop = marginValues[0];
              epubRendererCSS.marginBottom = marginValues[1];
              epubRendererCSS.marginLeft = marginValues[2];
              epubRendererCSS.marginRight = marginValues[3];
              break;
          }
          break;
        case 'margin-top':
          epubRendererCSS.marginTop = propertyValue;
          break;
        case 'margin-bottom':
          epubRendererCSS.marginBottom = propertyValue;
          break;
        case 'margin-left':
          epubRendererCSS.marginLeft = propertyValue;
          break;
        case 'margin-right':
          epubRendererCSS.marginRight = propertyValue;
          break;
        case 'padding':
          break;
        case 'padding-top':
          epubRendererCSS.paddingTop = propertyValue;
          break;
        case 'padding-bottom':
          epubRendererCSS.paddingBottom = propertyValue;
          break;
        case 'padding-left':
          epubRendererCSS.paddingLeft = propertyValue;
          break;
        case 'padding-right':
          epubRendererCSS.paddingRight = propertyValue;
          break;
        case 'font-size':
          epubRendererCSS.fontSize = propertyValue;
          break;
        case 'font-weight':
          epubRendererCSS.fontWeight = propertyValue == 'bold' ? FontWeight.bold : FontWeight.normal;
          break;
        case 'font-style':
          epubRendererCSS.fontStyle = _parseFontStyle(propertyValue);
          break;
        case 'font-family':
          epubRendererCSS.fontFamily = propertyValue;
          break;
        case 'font-variant':
          epubRendererCSS.fontVariant =
              propertyValue == 'small-caps' ? EpubRendererCSSFontVariant.smallCaps : EpubRendererCSSFontVariant.normal;
          break;
        case 'text-align':
          epubRendererCSS.textAlign = _parseTextAlign(propertyValue);
          break;
        case 'line-height':
          epubRendererCSS.lineHeight = double.parse(propertyValue);
          break;
        case 'letter-spacing':
          epubRendererCSS.letterSpacing = double.parse(propertyValue);
          break;
      }
    }

    return epubRendererCSS;
  }

  static TextAlign _parseTextAlign(String textAlign) {
    switch (textAlign) {
      case 'left':
        return TextAlign.left;
      case 'right':
        return TextAlign.right;
      case 'center':
        return TextAlign.center;
      case 'justify':
        return TextAlign.justify;
      default:
        return TextAlign.start;
    }
  }

  static FontStyle _parseFontStyle(String fontStyle) {
    switch (fontStyle) {
      case 'italic':
        return FontStyle.italic;
      case 'normal':
        return FontStyle.normal;
      default:
        return FontStyle.normal;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'marginTop': marginTop,
      'marginBottom': marginBottom,
      'marginLeft': marginLeft,
      'marginRight': marginRight,
      'paddingTop': paddingTop,
      'paddingBottom': paddingBottom,
      'paddingLeft': paddingLeft,
      'paddingRight': paddingRight,
      'fontSize': fontSize,
      'fontWeight': fontWeight.toString(),
      'fontStyle': fontStyle.toString(),
      'fontFamily': fontFamily,
      'fontVariant': fontVariant.toString(),
      'textAlign': textAlign.toString(),
      'lineHeight': lineHeight,
      'letterSpacing': letterSpacing,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}

enum EpubRendererCSSFontVariant { normal, smallCaps }
