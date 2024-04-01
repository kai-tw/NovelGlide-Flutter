import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_book_image_picker.dart';
import 'add_book_name_input_field.dart';
import 'add_book_submit_button.dart';
import 'bloc/add_book_form_bloc.dart';

class AddBookForm extends StatelessWidget {
  const AddBookForm({this.controller, super.key});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddBookFormCubit(),
      child: Form(
        child: SingleChildScrollView(
          controller: controller,
          child: const Column(
            children: [
              AddBookNameInputField(),
              Padding(padding: EdgeInsets.only(bottom: 20.0)),
              AddBookImagePicker(),
              Padding(padding: EdgeInsets.only(bottom: 16.0)),
              AddBookSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

}