import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/book_object.dart';
import 'bloc/edit_book_form_bloc.dart';
import 'edit_book_image_picker.dart';
import 'edit_book_name_text_field.dart';
import 'edit_book_submit_button.dart';
import 'edit_book_title.dart';

class EditBookForm extends StatelessWidget {
  EditBookForm({required this.bookObject, this.controller, super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final BookObject bookObject;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditBookFormCubit(bookObject),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: controller,
          child: const Column(
            children: [
              EditBookTitle(),
              Padding(padding: EdgeInsets.only(bottom: 16.0)),
              EditBookNameTextField(),
              Padding(padding: EdgeInsets.only(bottom: 20.0)),
              EditBookImagePicker(),
              Padding(padding: EdgeInsets.only(bottom: 16.0)),
              EditBookSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

}