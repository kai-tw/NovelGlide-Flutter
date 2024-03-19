import 'dart:async';

import 'package:flutter/material.dart';

import '../../shared/book_object.dart';
import 'edit_book_draggable_scrollable_sheet.dart';

class EditBookCalleeEditButton extends StatelessWidget {
  const EditBookCalleeEditButton({required this.bookObject, this.onSuccess, super.key});

  final BookObject bookObject;
  final void Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        EditBookDraggableScrollableSheet(bookObject: bookObject).show(context).then(_onValue);
      },
      icon: const Icon(Icons.edit_rounded),
    );
  }

  FutureOr<void> _onValue(dynamic isSuccess) {
    if (isSuccess != null && isSuccess && onSuccess != null) {
      onSuccess!();
    }
  }
}