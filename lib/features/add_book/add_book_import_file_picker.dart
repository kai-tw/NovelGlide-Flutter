import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_file_picker/common_file_picker.dart';
import '../common_components/common_file_picker/common_file_picker_type.dart';
import 'bloc/add_book_form_bloc.dart';

class AddBookImportFilePicker extends StatelessWidget {
  const AddBookImportFilePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final AddBookFormCubit cubit = BlocProvider.of<AddBookFormCubit>(context);
    return CommonFilePicker(
      inputDecoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.bookImporter + AppLocalizations.of(context)!.fieldOptional,
      ),
      isRequired: false,
      type: CommonFilePickerType.archive,
      onSaved: (file) => cubit.importArchiveFile = file,
    );
  }
}