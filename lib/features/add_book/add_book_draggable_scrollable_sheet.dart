import 'package:flutter/material.dart';

import '../common_components/common_draggable_scrollable_sheet.dart';
import 'add_book_form.dart';

class AddBookDraggableScrollableSheet extends StatelessWidget {
  const AddBookDraggableScrollableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonDraggableScrollableSheet(
      builder: (context, controller) {
        return AddBookForm(controller: controller);
      },
    );
  }
}