import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_book_form_bloc.dart';
import 'widgets/add_book_image_picker.dart';
import 'widgets/add_book_name_input_field.dart';
import 'widgets/add_book_submit_button.dart';

class AddBookForm extends StatelessWidget {
  const AddBookForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            constraints: const BoxConstraints(maxWidth: 360.0),
            child: BlocProvider(
              create: (_) => AddBookFormCubit(),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 32.0),
                    child: AddBookNameInputField(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 32.0),
                    child: AddBookImagePicker(),
                  ),
                  AddBookSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}