import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_book_sliver_image_picker.dart';
import 'add_book_sliver_name_text_field.dart';
import 'add_book_sliver_submit_button.dart';
import 'add_book_sliver_title.dart';
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
        child: CustomScrollView(
          controller: controller,
          slivers: const [
            AddBookSliverTitle(),
            SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
            AddBookSliverNameTextField(),
            SliverPadding(padding: EdgeInsets.only(bottom: 20.0)),
            AddBookSliverImagePicker(),
            SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
            AddBookSliverSubmitButton(),
          ],
        ),
      ),
    );
  }

}