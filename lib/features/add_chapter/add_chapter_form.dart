import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_chapter_name_input_field.dart';
import 'add_chapter_number_input_field.dart';
import 'add_chapter_title.dart';
import 'bloc/add_chapter_form_bloc.dart';

class AddChapterForm extends StatelessWidget {
  const AddChapterForm({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddChapterFormCubit(),
      child: Form(
        child: SingleChildScrollView(
          controller: controller,
          child: const Column(
            children: [
              AddChapterTitle(),
              Padding(padding: EdgeInsets.only(bottom: 16.0)),
              AddChapterNameInputField(),
              Padding(padding: EdgeInsets.only(bottom: 16.0)),
              AddChapterNumberInputField(),
            ],
          ),
        ),
      ),
    );
  }
}