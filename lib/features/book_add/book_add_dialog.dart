import 'package:flutter/material.dart';

import 'book_add_form.dart';

class BookAddDialog extends StatelessWidget {
  const BookAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: BookAddForm(),
    );
  }
}
