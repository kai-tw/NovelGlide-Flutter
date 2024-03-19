import 'package:flutter/material.dart';

import '../../shared/book_object.dart';
import '../common_components/common_draggable_scrollable_sheet.dart';
import 'edit_book_form.dart';

class EditBookDraggableScrollableSheet extends CommonDraggableScrollableSheet {
  EditBookDraggableScrollableSheet({
    required BookObject bookObject,
    super.key,
  }) : super(
          builder: (BuildContext context, ScrollController controller) {
            return EditBookForm(bookObject: bookObject, controller: controller);
          },
        );
}
