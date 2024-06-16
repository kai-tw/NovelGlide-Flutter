import 'package:flutter/material.dart';

import 'widgets/book_importer_overwrite_switch.dart';
import 'widgets/book_importer_submit_button.dart';
import 'widgets/book_importer_file_picker.dart';

class BookImporterForm extends StatelessWidget {
  const BookImporterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 32.0),
            child: BookImporterFilePicker(),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 32.0),
          //   child: BookImporterOverwriteSwitch(),
          // ),
          Align(
            alignment: Alignment.centerRight,
            child: BookImporterSubmitButton(),
          ),
        ],
      ),
    );
  }
}
