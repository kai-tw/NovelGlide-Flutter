import 'package:flutter/material.dart';

import 'edit_book_image_picker.dart';
import 'edit_book_name_input_field.dart';
import 'edit_book_submit_button.dart';
import 'edit_book_title.dart';

class EditBookForm extends StatelessWidget {
  const EditBookForm({this.controller, super.key});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        controller: controller,
        child: const Column(
          children: [
            EditBookTitle(),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
            EditBookNameInputField(),
            Padding(padding: EdgeInsets.only(bottom: 20.0)),
            EditBookImagePicker(),
            Padding(padding: EdgeInsets.only(bottom: 16.0)),
            EditBookSubmitButton(),
          ],
        ),
      ),
    );
  }

}