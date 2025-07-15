import 'package:flutter/material.dart';

class PopupMenuUtils {
  const PopupMenuUtils._();

  static void addSection<T>(
    List<PopupMenuEntry<T>> entries,
    List<PopupMenuEntry<T>> section,
  ) {
    if (section.isNotEmpty) {
      if (entries.isNotEmpty) {
        entries.addAll(<PopupMenuEntry<T>>[
          const PopupMenuDivider(),
          ...section,
        ]);
      } else {
        entries.addAll(section);
      }
    }
  }
}
