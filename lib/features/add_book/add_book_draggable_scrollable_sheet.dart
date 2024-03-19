import 'package:flutter/material.dart';

import '../common_components/common_draggable_scrollable_sheet.dart';
import 'add_book_form.dart';

class AddBookDraggableScrollableSheet extends CommonDraggableScrollableSheet {
  const AddBookDraggableScrollableSheet({super.key}) : super(builder: _builder);

  static Widget _builder(BuildContext context, ScrollController controller) {
    return AddBookForm(controller: controller);
  }
}