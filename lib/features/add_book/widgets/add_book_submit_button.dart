import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_components/common_form_components/common_form_submit_button.dart';
import '../bloc/add_book_form_bloc.dart';

class AddBookSubmitButton extends StatelessWidget {
  const AddBookSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CommonFormSubmitButton(
        onPressed: BlocProvider.of<AddBookFormCubit>(context).submit,
        onSuccess: () => Navigator.of(context).pop(true),
      ),
    );
  }
}