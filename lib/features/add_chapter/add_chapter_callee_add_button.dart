import 'package:flutter/material.dart';

import '../common_components/common_draggable_scrollable_sheet.dart';
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
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: CommonDraggableScrollableSheet.maxHeightRatio,
      showDragHandle: CommonDraggableScrollableSheet.showDragHandle,
      builder: (context) => const AddChapterDraggableScrollableSheet(),
    );
  }
}