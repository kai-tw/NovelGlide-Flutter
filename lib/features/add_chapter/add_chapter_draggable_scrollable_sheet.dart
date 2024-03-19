import 'package:flutter/material.dart';

import '../common_components/common_draggable_scrollable_sheet.dart';

class AddChapterDraggableScrollableSheet extends CommonDraggableScrollableSheet {
  const AddChapterDraggableScrollableSheet({super.key}) : super(builder: _builder);

  static Widget _builder(BuildContext context, ScrollController controller) {
    return const Text("ADD FORM");
  }
}
