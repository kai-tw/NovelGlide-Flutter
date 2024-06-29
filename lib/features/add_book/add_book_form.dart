import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/add_book_image_picker.dart';
import 'widgets/add_book_name_input_field.dart';
import 'widgets/add_book_submit_button.dart';
import 'bloc/add_book_form_bloc.dart';

class AddBookForm extends StatelessWidget {
  const AddBookForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddBookFormCubit(),
      child: const Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddBookNameInputField(),
              Padding(padding: EdgeInsets.only(bottom: 32.0)),
              AddBookImagePicker(),
              Padding(padding: EdgeInsets.only(bottom: 32.0)),
              AddBookSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

}