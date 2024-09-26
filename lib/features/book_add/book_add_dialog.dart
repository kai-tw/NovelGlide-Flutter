import 'package:flutter/material.dart';

import '../../enum/window_class.dart';
import 'book_add_form.dart';

class BookAddDialog extends StatelessWidget {
  const BookAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: WindowClass.compact.maxWidth),
        child: const BookAddForm(),
      ),
    );
  }
}
