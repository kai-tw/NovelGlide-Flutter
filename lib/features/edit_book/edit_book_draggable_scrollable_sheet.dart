import 'package:flutter/material.dart';

import '../../shared/book_object.dart';
import 'edit_book_form.dart';

class EditBookDraggableScrollableSheet extends StatelessWidget {
  const EditBookDraggableScrollableSheet({required this.bookObject, super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.25,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      snapSizes: const [0.6],
      builder: (BuildContext context, ScrollController controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: EditBookForm(controller: controller),
        );
      },
    );
  }

}