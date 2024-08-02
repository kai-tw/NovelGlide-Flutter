import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_chapter_form_bloc.dart';
import 'widgets/add_chapter_file_picker.dart';
import 'widgets/add_chapter_number_input_field.dart';
import 'widgets/add_chapter_submit_button.dart';
import 'widgets/add_chapter_title_input_field.dart';

class AddChapterForm extends StatelessWidget {
  final String bookName;

  const AddChapterForm({super.key, required this.bookName});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            constraints: const BoxConstraints(maxWidth: 360),
            child: BlocProvider(
              create: (_) => AddChapterFormCubit(bookName),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 32.0),
                    child: AddChapterNumberInputField(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 32.0),
                    child: AddChapterTitleInputField(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 32.0),
                    child: AddChapterFilePicker(),
                  ),
                  AddChapterSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}