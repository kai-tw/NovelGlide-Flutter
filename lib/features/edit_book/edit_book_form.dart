import 'package:flutter/material.dart';

import 'edit_book_sliver_image_picker.dart';
import 'edit_book_sliver_name_text_field.dart';
import 'edit_book_sliver_submit_button.dart';
import 'edit_book_sliver_title.dart';

class EditBookForm extends StatelessWidget {
  EditBookForm({this.controller, super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: CustomScrollView(
        controller: controller,
        slivers: const [
          EditBookSliverTitle(),
          SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
          EditBookSliverNameTextField(),
          SliverPadding(padding: EdgeInsets.only(bottom: 20.0)),
          EditBookSliverImagePicker(),
          SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
          EditBookSliverSubmitButton(),
        ],
      ),
    );
  }

}