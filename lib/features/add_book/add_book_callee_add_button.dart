import 'dart:async';

import 'package:flutter/material.dart';

import 'add_book_draggable_scrollable_sheet.dart';

class AddBookCalleeAddButton extends StatelessWidget {
  const AddBookCalleeAddButton({this.callback, super.key});

  final void Function(dynamic)? callback;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          scrollControlDisabledMaxHeightRatio: 1.0,
          showDragHandle: true,
          builder: (BuildContext context) {
            return const AddBookDraggableScrollableSheet();
          },
        ).then(onValue);
      },
      shape: const CircleBorder(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
    );
  }

  FutureOr<void> onValue(dynamic retValue) {
    if (callback != null) {
      callback!(retValue);
    }
  }
}