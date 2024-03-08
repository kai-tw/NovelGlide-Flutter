import 'package:flutter/material.dart';

import '../../shared/book_object.dart';
import 'edit_book_form.dart';

class EditBookPage extends StatelessWidget {
  const EditBookPage(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return EditBookForm(bookObject: bookObject);
  }
}
