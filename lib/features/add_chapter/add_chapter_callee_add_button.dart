import 'package:flutter/material.dart';

import '../common_components/common_draggable_scrollable_sheet.dart';
import 'add_chapter_draggable_scrollable_sheet.dart';

class AddChapterCalleeAddButton extends StatelessWidget {
  const AddChapterCalleeAddButton(this.bookName, {super.key, this.onPopBack});

  final String bookName;
  final void Function(dynamic)? onPopBack;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          scrollControlDisabledMaxHeightRatio: CommonDraggableScrollableSheet.maxHeightRatio,
          showDragHandle: CommonDraggableScrollableSheet.showDragHandle,
          builder: (context) => AddChapterDraggableScrollableSheet(bookName),
        ).then(onPopBack ?? (_) {});
      },
      shape: const CircleBorder(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(Icons.add_rounded, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}