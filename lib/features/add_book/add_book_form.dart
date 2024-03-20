import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_book_image_picker.dart';
import 'add_book_name_text_field.dart';
import 'add_book_submit_button.dart';
import 'add_book_title.dart';
import 'bloc/add_book_form_bloc.dart';

class AddBookForm extends StatelessWidget {
  AddBookForm({this.controller, super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddBookFormCubit(),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: controller,
          child: const Column(
            children: [
              AddBookTitle(),
              Padding(padding: EdgeInsets.only(bottom: 16.0)),
              AddBookNameTextField(),
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