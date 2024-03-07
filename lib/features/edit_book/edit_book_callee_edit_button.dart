import 'package:flutter/material.dart';

import '../../shared/book_object.dart';
import 'edit_book_bloc_provider_wrapper.dart';
import 'edit_book_draggable_scrollable_sheet.dart';

class EditBookCalleeEditButton extends StatelessWidget {
  const EditBookCalleeEditButton({required this.bookObject, this.onSuccess, super.key});

  final BookObject bookObject;
  final void Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          scrollControlDisabledMaxHeightRatio: 1.0,
          showDragHandle: true,
          builder: (BuildContext context) {
            return EditBookBlocProviderWrapper(
              bookObject: bookObject,
              child: EditBookDraggableScrollableSheet(bookObject: bookObject),
            );
          },
        ).then((isSuccess) {
          if (isSuccess != null && isSuccess && onSuccess != null) {
            onSuccess!();
          }
        });
      },
      icon: const Icon(Icons.edit_rounded),
    );
  }

}