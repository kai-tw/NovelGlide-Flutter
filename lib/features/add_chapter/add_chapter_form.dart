import 'package:flutter/material.dart';

import 'widgets/add_chapter_file_picker.dart';
import 'widgets/add_chapter_title_input_field.dart';
import 'widgets/add_chapter_number_input_field.dart';
import 'widgets/add_chapter_submit_button.dart';

class AddChapterForm extends StatelessWidget {
  const AddChapterForm({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        controller: controller,
        child: const Column(
          children: [
            AddChapterNumberInputField(),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
            AddChapterTitleInputField(),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
            AddChapterFilePicker(),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
            AddChapterSubmitButton(),
          ],
        ),
      ),
    );
  }
}
