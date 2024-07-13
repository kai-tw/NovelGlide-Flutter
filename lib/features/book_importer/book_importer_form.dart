import 'package:flutter/material.dart';

import 'widgets/book_importer_file_picker.dart';
import 'widgets/book_importer_submit_button.dart';

class BookImporterForm extends StatelessWidget {
  const BookImporterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.0, bottom: 32.0),
            child: BookImporterFilePicker(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: BookImporterSubmitButton(),
          ),
        ],
      ),
    );
  }
}