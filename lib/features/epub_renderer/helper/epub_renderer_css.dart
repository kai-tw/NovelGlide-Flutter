import 'package:flutter/material.dart';

class EpubRendererCSS {
  EdgeInsets margin;
  EdgeInsets padding;
  double fontSize;
  FontWeight fontWeight;
  FontStyle fontStyle;
  String fontFamily;
  TextAlign textAlign;
  double lineHeight;
  double letterSpacing;

  EpubRendererCSS({
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.fontStyle = FontStyle.normal,
    this.fontFamily = "",
    this.textAlign = TextAlign.start,
    this.lineHeight = 1.2,
    this.letterSpacing = 0,
  });
}
