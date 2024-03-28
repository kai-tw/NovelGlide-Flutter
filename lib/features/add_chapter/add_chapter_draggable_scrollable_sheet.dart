import 'package:flutter/material.dart';

import '../common_components/common_draggable_scrollable_sheet.dart';
import 'add_chapter_form.dart';

class AddChapterDraggableScrollableSheet extends StatelessWidget {
  const AddChapterDraggableScrollableSheet(this.bookName, {super.key});

  final String bookName;

  @override
  Widget build(BuildContext context) {
    return CommonDraggableScrollableSheet(
      builder: (context, controller) {
        return AddChapterForm(bookName, controller: controller);
      },
    );
  }
}
