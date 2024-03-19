import 'package:flutter/material.dart';

import 'add_chapter_draggable_scrollable_sheet.dart';

class AddChapterCalleeAddButton extends StatelessWidget {
  const AddChapterCalleeAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _onPressed(context),
      icon: const Icon(Icons.add_rounded),
    );
  }

  void _onPressed(BuildContext context) {
    const AddChapterDraggableScrollableSheet().show(context);
  }
}