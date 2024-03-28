import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/book_object.dart';
import '../common_components/common_draggable_scrollable_sheet.dart';
import 'bloc/edit_book_form_bloc.dart';
import 'edit_book_draggable_scrollable_sheet.dart';

class EditBookCalleeEditButton extends StatelessWidget {
  const EditBookCalleeEditButton({required this.bookObject, this.onPopBack, super.key});

  final BookObject bookObject;
  final void Function(dynamic)? onPopBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          scrollControlDisabledMaxHeightRatio: CommonDraggableScrollableSheet.maxHeightRatio,
          showDragHandle: CommonDraggableScrollableSheet.showDragHandle,
          builder: (context) {
            return BlocProvider(
              create: (_) => EditBookFormCubit(bookObject),
              child: const EditBookDraggableScrollableSheet()
            );
          },
        ).then(onPopBack ?? (_) {});
      },
      icon: const Icon(Icons.edit_rounded),
    );
  }
}