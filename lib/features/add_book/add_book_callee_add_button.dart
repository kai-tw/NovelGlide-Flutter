import 'package:flutter/material.dart';
import 'package:novelglide/features/common_components/common_draggable_scrollable_sheet.dart';

import 'add_book_scaffold.dart';
import 'add_book_form.dart';

class AddBookCalleeAddButton extends StatelessWidget {
  const AddBookCalleeAddButton({this.onPopBack, super.key});

  final void Function(dynamic)? onPopBack;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const AddBookScaffold(),
          ),
        ).then(onPopBack ?? (_) {});
      },
      shape: const CircleBorder(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}