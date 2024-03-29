import 'package:flutter/material.dart';
import 'package:novelglide/features/common_components/common_draggable_scrollable_sheet.dart';

import 'add_book_draggable_scrollable_sheet.dart';

class AddBookCalleeAddButton extends StatelessWidget {
  const AddBookCalleeAddButton({this.onPopBack, super.key});

  final void Function(dynamic)? onPopBack;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          scrollControlDisabledMaxHeightRatio: CommonDraggableScrollableSheet.maxHeightRatio,
          showDragHandle: CommonDraggableScrollableSheet.showDragHandle,
          builder: (context) {
            return const AddBookDraggableScrollableSheet();
          },
        ).then(onPopBack ?? (_) {});
      },
      shape: const CircleBorder(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}