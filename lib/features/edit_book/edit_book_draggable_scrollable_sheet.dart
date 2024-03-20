import 'package:flutter/material.dart';

import '../common_components/common_draggable_scrollable_sheet.dart';
import 'edit_book_form.dart';

class EditBookDraggableScrollableSheet extends StatelessWidget {
  const EditBookDraggableScrollableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonDraggableScrollableSheet(
      builder: (context, controller) {
        return EditBookForm(controller: controller);
      },
    );
  }
}
