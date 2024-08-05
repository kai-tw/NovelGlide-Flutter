import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/book_importer_bloc.dart';
import 'widgets/book_importer_file_picker.dart';
import 'widgets/book_importer_submit_button.dart';
import '../common_components/zip_encoding_dropdown_menu.dart';

class BookImporterForm extends StatelessWidget {
  const BookImporterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final BookImporterCubit cubit = BookImporterCubit();
    return Form(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 360),
            child: BlocProvider(
              create: (context) => cubit,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6.0, bottom: 32.0),
                    child: BookImporterFilePicker(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: ZipEncodingDropdownMenu(
                      onSelected: (zipEncoding) => cubit.setZipEncoding(zipEncoding),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: BookImporterSubmitButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}