import 'package:flutter/material.dart';

import '../common_components/common_draggable_scrollable_sheet.dart';
import 'add_chapter_form.dart';

class AddChapterDraggableScrollableSheet extends StatelessWidget {
  const AddChapterDraggableScrollableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonDraggableScrollableSheet(
      builder: (context, controller) {
        return const AddChapterForm();
      },
    );
  }
}
