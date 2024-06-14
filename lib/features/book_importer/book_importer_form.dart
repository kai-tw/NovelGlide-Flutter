import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_components/common_form_components/common_form_submit_button.dart';
import 'bloc/book_importer_bloc.dart';
import 'widgets/book_importer_file_picker.dart';

class BookImporterForm extends StatelessWidget {
  const BookImporterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BookImporterCubit>(context);
    return Form(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 32.0),
            child: BookImporterFilePicker(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CommonFormSubmitButton(
              onPressed: cubit.submit,
              onSuccess: () => Navigator.of(context).pop(true),
              onFailed: (e) {
                print(e);
              },
            ),
          ),
        ],
      ),
    );
  }
}
