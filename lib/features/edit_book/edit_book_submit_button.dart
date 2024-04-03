import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_form_submit_button.dart';
import 'bloc/edit_book_form_bloc.dart';

class EditBookSubmitButton extends StatelessWidget {
  const EditBookSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CommonFormSubmitButton(
        onPressed: BlocProvider.of<EditBookFormCubit>(context).submit,
        onSuccess: () => Navigator.of(context).pop(true),
      ),
    );
  }
}